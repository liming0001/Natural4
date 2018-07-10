//
//  LXNetworkConfig.m
//  ProjectSource_Demo
//
//  Created by Liu on 16/3/29.
//  Copyright © 2016年 AngryBear. All rights reserved.
//

#import "LXNetworkConfig.h"
#import "OpenUDID.h"

//120.76.45.180
#define kBaseURL @"https://www.bigweiba.com"
#define kHTTPCookieDomain @"www.bigweiba.com"

@implementation LXNetworkConfig

+ (LXNetworkConfig *)defaultConfig {
    static LXNetworkConfig *config;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[LXNetworkConfig alloc] init];
    });
    return config;
}

- (NSString *)baseURL {
    return kBaseURL;
}

- (void)addCookie {
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    NSString *version = info[@"CFBundleShortVersionString"];
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:@"ClientVersion" forKey:NSHTTPCookieName];
    [cookieProperties setObject:version forKey:NSHTTPCookieValue];
    [cookieProperties setObject:kHTTPCookieDomain forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:kBaseURL forKey:NSHTTPCookieOriginURL];
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    
    NSString *openID = [OpenUDID value];
    NSMutableDictionary *cookieProperties1 = [NSMutableDictionary dictionary];
    [cookieProperties1 setObject:@"taddr" forKey:NSHTTPCookieName];
    [cookieProperties1 setObject:openID forKey:NSHTTPCookieValue];
    [cookieProperties1 setObject:kHTTPCookieDomain forKey:NSHTTPCookieDomain];
    [cookieProperties1 setObject:kBaseURL forKey:NSHTTPCookieOriginURL];
    [cookieProperties1 setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties1 setObject:@"0" forKey:NSHTTPCookieVersion];
    NSHTTPCookie *cookie1 = [NSHTTPCookie cookieWithProperties:cookieProperties1];
    
    NSString *sessionID = USERVALUE.userInfo.sessionId ? USERVALUE.userInfo.sessionId : @"";
    NSMutableDictionary *cookieProperties2 = [NSMutableDictionary dictionary];
    [cookieProperties2 setObject:@"sessionId" forKey:NSHTTPCookieName];
    [cookieProperties2 setObject:sessionID forKey:NSHTTPCookieValue];
    [cookieProperties2 setObject:kHTTPCookieDomain forKey:NSHTTPCookieDomain];
    [cookieProperties2 setObject:kBaseURL forKey:NSHTTPCookieOriginURL];
    [cookieProperties2 setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties2 setObject:@"0" forKey:NSHTTPCookieVersion];
    NSHTTPCookie *cookie2 = [NSHTTPCookie cookieWithProperties:cookieProperties2];
    
    
    CLLocationCoordinate2D coor = [CommonUtility sharedManager].userCoordinate;
    NSString *gpsLocation = @"UNKNOWN";
    if (coor.latitude > 0 || coor.longitude > 0) {
        gpsLocation = [NSString stringWithFormat:@"%fE|%fN", coor.longitude, coor.latitude];
    }
    NSMutableDictionary *cookieProperties3 = [NSMutableDictionary dictionary];
    [cookieProperties3 setObject:@"gpsLocation" forKey:NSHTTPCookieName];
    [cookieProperties3 setObject:gpsLocation forKey:NSHTTPCookieValue];
    [cookieProperties3 setObject:kHTTPCookieDomain forKey:NSHTTPCookieDomain];
    [cookieProperties3 setObject:kBaseURL forKey:NSHTTPCookieOriginURL];
    [cookieProperties3 setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties3 setObject:@"0" forKey:NSHTTPCookieVersion];
    NSHTTPCookie *cookie3 = [NSHTTPCookie cookieWithProperties:cookieProperties3];
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie1];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie2];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie3];
}

@end
