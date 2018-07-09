//
//  LXBaseRequester.m
//  ProjectSource_Demo
//
//  Created by Liu on 16/3/28.
//  Copyright © 2016年 AngryBear. All rights reserved.
//

#import "LXBaseRequest.h"
#import <objc/runtime.h>
#import "LXHTTPRequestManager.h"

@interface LXBaseRequest ()
{
    NetworkSuccessHandle _successHandle;
    NetworkFailureHandle _failureHandle;
    NetworkCompletionHandle _completionHandle;
}

@end

@implementation LXBaseRequest

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - Public Methods
/** 请求的url字符串 */
- (NSString *)urlString
{
    return nil;
}

/** 请求的超时时间，default is 15 seconds. */
- (NSTimeInterval)timeoutInterval
{
    return 15;
}

/** 请求的缓存策略 */
- (NSURLRequestCachePolicy)cachePolicy
{
    return NSURLRequestUseProtocolCachePolicy;
}

/** http请求的方法 */
- (LXHTTPRequestMethod)httpMethod
{
    return LXHTTPRequestMethodPost;
}

/** 请求头 */
- (NSDictionary *)httpHeader
{
    return nil;
}

/** 请求参数 */
- (NSDictionary *)requestParameters
{
    return [self dictionaryForPropertyList];
}

- (NSString *)parametersString
{
    NSDictionary *dic = [self dictionaryForPropertyList];
    
    NSArray *allKeys = dic.allKeys;
    allKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSMutableString *paramString = [NSMutableString stringWithString:@""];
    for (NSString *key in allKeys) {
        id value = [dic objectForKey:key];
        [paramString appendFormat:@"%@=%@", key, value];
        if (key != [allKeys lastObject]) {
            [paramString appendFormat:@"&"];
        }
    }
    
    return paramString;
}

- (LXRequestSerializerType)requestType
{
    return LXRequestSerializerTypeHTTP;
}

- (void)startWithCompletionBlockWithSuccess:(NetworkSuccessHandle)success failure:(NetworkFailureHandle)failure
{
    _successHandle = success;
    _failureHandle = failure;
    
    [[LXHTTPRequestManager manager] addRequest:self];
}

- (void)startWithCompletionHandle:(NetworkCompletionHandle)complete
{
    _completionHandle = complete;
    [[LXHTTPRequestManager manager] addRequest:self];
}

- (void)cancelRequest
{
    [[LXHTTPRequestManager manager] removeRequest:self];
}

- (NetworkSuccessHandle)successHandle
{
    return _successHandle;
}

- (NetworkFailureHandle)failureHandle
{
    return _failureHandle;
}

- (NetworkCompletionHandle)completionHandle
{
    return _completionHandle;
}

- (ConstructingBodyBlock)constructingBodyBlock {
    return nil;
}

#pragma mark - Private Methods

- (NSDictionary *)dictionaryForPropertyList
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    
    Class klass = [self class];
    while (![NSStringFromClass(klass) isEqualToString:@"LXBaseRequest"]) {
        unsigned int count;
        objc_property_t *propertyList = class_copyPropertyList(klass, &count);
        
        for (int i = 0; i < count; i++) {
            objc_property_t property = propertyList[i];
            const char *propertyName = property_getName(property);
            NSString *key = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
            if ([key isEqualToString:@"imageData"]) {
                continue;
            }
            id value = [self valueForKey:key];
            if (value) {
                if ([value isKindOfClass:[NSString class]]) {
                    if (!((NSString *)value).length) {
                        continue;
                    }
                }
                [dictionary setValue:value forKey:key];
            }
        }
        free(propertyList);
        
        klass = [klass superclass];
    }

    return dictionary;
}

@end

