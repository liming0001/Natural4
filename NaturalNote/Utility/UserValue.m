//
//  UserValue.m
//  NaturalNote
//
//  Created by Liu on 16/9/24.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import "UserValue.h"

static NSString *const kZLSaveUserValueKey = @"kZLSaveUserValueKey";

@implementation UserValue

+ (UserValue *)shareInstance
{
    static UserValue *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *base64Str = [[NSUserDefaults standardUserDefaults] objectForKey:kZLSaveUserValueKey];
        if (base64Str) {
            NSString *jsonString = [base64Str lxc_decodeFormBase64String];
            NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            id value = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if ([value isKindOfClass:[NSDictionary class]]) {
                instance = [UserValue mj_objectWithKeyValues:value];
            }
            else {
                instance = [[UserValue alloc] init];
            }
        }
        else {
            instance = [[UserValue alloc] init];
        }
        
    });
    return instance;
}

- (void)saveToDisk
{
    @synchronized(self) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *userValue = [self mj_keyValues];
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userValue options:0 error:nil];
            NSString *string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSString *base64String = [string lxc_Base64String];
            [[NSUserDefaults standardUserDefaults] setObject:base64String forKey:kZLSaveUserValueKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        });
    }
}

- (void)logoutAndClearValue
{
    self.userInfo = nil;
    [self saveToDisk];
}

@end
