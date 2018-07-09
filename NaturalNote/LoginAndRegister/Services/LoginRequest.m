//
//  LoginRequest.m
//  NaturalNote
//
//  Created by Liu on 16/9/18.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest

- (NSString *)urlString {
    return @"/naturenote/spring/user/login";
}

@end

@implementation LoginResponse

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"camps" : @"CampsObject"};
}

@end

@implementation CampsObject

@end