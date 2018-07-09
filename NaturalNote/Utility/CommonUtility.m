//
//  CommonUtility.m
//  NaturalNote
//
//  Created by 李黎明 on 2017/5/25.
//  Copyright © 2017年 Liu. All rights reserved.
//

#import "CommonUtility.h"
#import <BaiduMapAPI_Utils/BMKGeometry.h>

@implementation CommonUtility

+ (CommonUtility *)sharedManager
{
    static CommonUtility *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

+ (NSString *) ReturnBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return @"";
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return @"";
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return @"";
    }
    return string;
}

+(double)distanceBetweenOrderBy:(double)lat1 :(double)lat2 :(double)lng1 :(double)lng2{
    double dd = M_PI/180;
    double x1=lat1*dd,x2=lat2*dd;
    double y1=lng1*dd,y2=lng2*dd;
    double R = 6371004;
    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    //km  返回
    //return  distance*1000;
    //返回 m
    return   distance;
}

@end
