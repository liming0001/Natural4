//
//  LXHTTPRequestManager.m
//  ProjectSource_Demo
//
//  Created by Liu on 16/3/29.
//  Copyright © 2016年 AngryBear. All rights reserved.
//

#import "LXHTTPRequestManager.h"
#import "LXNetworkConfig.h"
#import "JPUSHService.h"
#import <AFNetworking/AFNetworking.h>


#if DEBUG
#define LXNetworkLog(...) NSLog(__VA_ARGS__)
#else
#define LXNetworkLog(...) {}
#endif

@interface LXHTTPRequestManager ()
{
    AFHTTPSessionManager *_manager;
    NSLock *_lock;
}
@property (nonatomic, strong) NSMutableArray *requestArray;

@end

@implementation LXHTTPRequestManager

- (instancetype)init
{
    if (self = [super init]) {
        _requestArray = [NSMutableArray array];
        _manager = [AFHTTPSessionManager manager];
        _lock = [[NSLock alloc] init];
    }
    return self;
}

#pragma mark - Public Methods
+ (LXHTTPRequestManager *)manager
{
    static LXHTTPRequestManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LXHTTPRequestManager alloc] init];
    });
    return manager;
}

- (void)addRequest:(LXBaseRequest *)request
{
    @synchronized(self.requestArray) {
        if (![self isContainedRequest:request]) {
            [self.requestArray addObject:request];
            
            [self startWithRequest:request];
        }
    }
}

- (void)removeRequest:(LXBaseRequest *)request
{
    [request.task cancel];
    
    @synchronized(self.requestArray) {
        [self.requestArray removeObject:request];
    }
}

- (void)startWithRequest:(LXBaseRequest *)request
{
    NSString *path = [request urlString];
    NSString *baseURL = [[LXNetworkConfig defaultConfig] baseURL];
    NSString *url = [NSString stringWithFormat:@"%@%@", baseURL, path];
    
    LXHTTPRequestMethod method = [request httpMethod];
    id param = [request requestParameters];

    switch ([request requestType]) {
        case LXRequestSerializerTypeJson:
            _manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        case LXRequestSerializerTypeHTTP:
            _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
             break;
        default:
            break;
    }
    
    _manager.requestSerializer.timeoutInterval = [request timeoutInterval]; //设置超时时间
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];    //设置json格式接收数据响应
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                          @"text/json",
                                                          @"text/javascript",
                                                          @"text/html",
                                                          @"text/plain",
                                                          @"application/xml",
                                                          @"image/jpeg",
                                                          @"image/png",
                                                          @"application/octet-stream", nil]; //设置接收数据的格式
    
    // if api need add custom value to HTTPHeaderField
    NSDictionary *headerFieldValueDictionary = [request httpHeader];
    if (headerFieldValueDictionary != nil) {
        for (id httpHeaderField in headerFieldValueDictionary.allKeys) {
            id value = headerFieldValueDictionary[httpHeaderField];
            if ([httpHeaderField isKindOfClass:[NSString class]] && [value isKindOfClass:[NSString class]]) {
                [_manager.requestSerializer setValue:(NSString *)value forHTTPHeaderField:(NSString *)httpHeaderField];
            }
            else {
                LXNetworkLog(@"Error, class of key/value in headerFieldValueDictionary should be NSString.");
            }
        }
    }
    
    [self logRequest:request url:url];
    [[LXNetworkConfig defaultConfig] addCookie];
    
    void (^success)() = ^(NSURLSessionDataTask *task, id _Nullable responseObject) {
        [self logResponseWithOperation:task error:nil request:request responseObject:responseObject];
        
        NetworkSuccessHandle success = [request successHandle];
        if (success) {
            success(request, responseObject);
        }
        
        NetworkCompletionHandle complete = [request completionHandle];
        if (complete) {
            complete(request, responseObject, YES);
        }
    };
    
    void (^failure)() = ^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        [self logResponseWithOperation:task error:error request:request responseObject:nil];
        
        NetworkFailureHandle failure = [request failureHandle];
        if (failure) {
            failure(request);
        }
        
        NetworkCompletionHandle complete = [request completionHandle];
        if (complete) {
            complete(request, nil, NO);
        }
    };
    
    if (method == LXHTTPRequestMethodGet) {
        request.task = [_manager GET:url parameters:param progress:nil success:success failure:failure];
    }
    else if (method == LXHTTPRequestMethodPost) {
        request.task = [_manager POST:url parameters:param constructingBodyWithBlock:[request constructingBodyBlock] progress:nil success:success failure:failure];
    }
    else if (method == LXHTTPRequestMethodHead) {
        request.task = [_manager HEAD:url parameters:param success:success failure:failure];
    }
    else if (method == LXHTTPRequestMethodPut) {
        request.task = [_manager PUT:url parameters:param success:success failure:failure];
    }
    else if (method == LXHTTPRequestMethodDelete) {
        request.task = [_manager DELETE:url parameters:param success:success failure:failure];
    }
    else if (method == LXHTTPRequestMethodPatch) {
        request.task = [_manager PATCH:url parameters:param success:success failure:failure];
    }
    else {
        LXNetworkLog(@"Error, unsupport http method type!");
    }
}

- (BOOL)isContainedRequest:(LXBaseRequest *)request
{
    if (request.canRepeat) {
        return NO;
    }
    for (LXBaseRequest *item in self.requestArray) {
        if ([[item urlString] isEqualToString:[request urlString]] && [[item parametersString] isEqualToString:[request parametersString]]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - Log Info
- (void)logRequest:(LXBaseRequest *)request url:(NSString *)url
{
#ifdef DEBUG
    [_lock lock];
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n**************************************************************\n*                          请求开始                           *\n**************************************************************\n"];
    
    [logString appendFormat:@"请求方式：%@\n", [self stringForMethod:[request httpMethod]]];
    [logString appendFormat:@"超时时间：%@\n", @(request.timeoutInterval)];
    [logString appendFormat:@"请求地址：%@\n", url];
    [logString appendFormat:@"请求参数：%@\n", [request requestParameters]];
    [logString appendFormat:@"httpheader：%@\n", request.httpHeader ? request.httpHeader : @"空"];
    [logString appendFormat:@"**************************************************************\n\n"];
    
    NSLog(@"%@", logString);
    [_lock unlock];
#endif
}

- (void)logResponseWithOperation:(NSURLSessionDataTask *)task error:(NSError *)error request:(LXBaseRequest *)baseRequest responseObject:(id)responseObject
{
    @synchronized(self.requestArray) {
        [self.requestArray removeObject:baseRequest];
    }
    
    [self logoutlogoutWithResponseObject:responseObject];
    
#ifdef DEBUG
    [_lock lock];
    BOOL shouldLogError = error ? YES : NO;
    
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n==============================================================\n=                           请求返回                          =\n==============================================================\n"];
    
    NSURLRequest *request = task.originalRequest;
    [logString appendFormat:@"请求地址：%@://%@%@\n\n", request.URL.scheme, request.URL.host, request.URL.path];
    [logString appendFormat:@"请求状态：\n\t%ld\n\n", ((NSHTTPURLResponse *)(task.response)).statusCode];
    [logString appendFormat:@"get子串：\n\t%@\n\n", request.URL.query];
    if (responseObject) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [logString appendFormat:@"返回json数据：\n\n%@\n", jsonString];
    }

    if (shouldLogError) {
        [logString appendFormat:@"Error Domain:\t\t\t\t\t\t\t%@\n", error.domain];
        [logString appendFormat:@"Error Domain Code:\t\t\t\t\t\t%ld\n", (long)error.code];
        [logString appendFormat:@"Error Localized Description:\t\t\t%@\n", error.localizedDescription];
        [logString appendFormat:@"Error Localized Failure Reason:\t\t\t%@\n", error.localizedFailureReason];
        [logString appendFormat:@"Error Localized Recovery Suggestion:\t%@\n\n", error.localizedRecoverySuggestion];
    }
    
    [logString appendFormat:@"==============================================================\n\n"];
    
    NSLog(@"%@", logString);
    [_lock unlock];
#endif
}

- (void)logoutlogoutWithResponseObject:(id)response {
    if ([response isKindOfClass:[NSDictionary class]]) {
        NSString *desc = response[@"desc"];
        if (desc && [desc isKindOfClass:[NSString class]] && ([desc rangeOfString:@"重新登陆"].length || [desc rangeOfString:@"重新登录"].length)) {
            [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                
            } seq:1];
            [USERVALUE logoutAndClearValue];
        }
    }
}

- (NSString *)stringForMethod:(LXHTTPRequestMethod)method
{
    switch (method) {
        case LXHTTPRequestMethodGet:
            return @"GET";
            break;
        case LXHTTPRequestMethodPost:
            return @"POST";
            break;
        case LXHTTPRequestMethodHead:
            return @"HEAD";
            break;
        case LXHTTPRequestMethodPut:
            return @"PUT";
            break;
        case LXHTTPRequestMethodDelete:
            return @"DELETE";
            break;
        case LXHTTPRequestMethodPatch:
            return @"PATCH";
            break;
        default:
            break;
    }
}

@end
