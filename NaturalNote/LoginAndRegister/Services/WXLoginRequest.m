//
//  WXLoginRequest.m
//  NaturalNote
//
//  Created by 李黎明 on 2017/10/26.
//  Copyright © 2017年 Liu. All rights reserved.
//

#import "WXLoginRequest.h"

@implementation WXLoginRequest

- (NSString *)urlString {
    return @"/naturenote/spring/user/wxlogin";
}

@end

@implementation WXLoginResponse

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"camps" : @"CampsObject"};
}

@end
