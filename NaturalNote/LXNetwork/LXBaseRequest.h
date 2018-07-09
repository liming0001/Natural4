//
//  LXBaseRequester.h
//  ProjectSource_Demo
//
//  Created by Liu on 16/3/28.
//  Copyright © 2016年 AngryBear. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LXHTTPRequestMethod) {
    LXHTTPRequestMethodGet,         //GET
    LXHTTPRequestMethodPost,        //POST
    LXHTTPRequestMethodHead,        //HEAD
    LXHTTPRequestMethodPut,         //PUT
    LXHTTPRequestMethodDelete,      //DELETE
    LXHTTPRequestMethodPatch        //PATCH
};

typedef NS_ENUM(NSInteger, LXRequestSerializerType) {
    LXRequestSerializerTypeJson,    //请求参数为json
    LXRequestSerializerTypeHTTP     //请求参数为http格式
};

@class LXBaseRequest, AFMultipartFormData;
typedef void (^NetworkSuccessHandle)(LXBaseRequest *request, id response);
typedef void (^NetworkFailureHandle)(LXBaseRequest *request);
typedef void (^NetworkCompletionHandle)(LXBaseRequest *request, id response, BOOL success);
typedef void (^ConstructingBodyBlock)(id <AFMultipartFormData> formData);

@interface LXBaseRequest : NSObject
@property (nonatomic, assign) BOOL canRepeat;   //是否可以同时请求
@property (nonatomic, strong) NSURLSessionDataTask *task;

/** 请求的url字符串 */
- (NSString *)urlString;

/** 请求的超时时间，default is 15 seconds. */
- (NSTimeInterval)timeoutInterval;

/** 请求的缓存策略 */
- (NSURLRequestCachePolicy)cachePolicy;

/** http请求的方法,默认post */
- (LXHTTPRequestMethod)httpMethod;

/** 请求头 */
- (NSDictionary *)httpHeader;

/** 请求参数,子类不重载的话，将转化子类的属性，生成包含子类属性的字典 */
- (NSDictionary *)requestParameters;

/** 请求的get字符串, 按升序排列 */
- (NSString *)parametersString;

/**
 *  请求类型，默认是HTTP
 */
- (LXRequestSerializerType)requestType;

/** 开始请求，请求完成后成功回调，失败回调 */
- (void)startWithCompletionBlockWithSuccess:(NetworkSuccessHandle)success
                                    failure:(NetworkFailureHandle)failure;

/**
 *  请求网络，成功和失败在一个block里面
 *
 *  @param complete 成功、失败的处理block
 */
- (void)startWithCompletionHandle:(NetworkCompletionHandle)complete;


/** 取消网络请求 */
- (void)cancelRequest;


- (NetworkSuccessHandle)successHandle;
- (NetworkFailureHandle)failureHandle;
- (NetworkCompletionHandle)completionHandle;
- (ConstructingBodyBlock)constructingBodyBlock;

/**
 *  获取requst的属性组成的字典，尽量不要使用，仅在- (NSDictionary *)requestParameters;中使用
 *
 *  @return 字典
 */
- (NSDictionary *)dictionaryForPropertyList;

@property (nonatomic, strong) NSData *imageData;

@end


