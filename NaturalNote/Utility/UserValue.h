//
//  UserValue.h
//  NaturalNote
//
//  Created by Liu on 16/9/24.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginRequest.h"

#define USERVALUE [UserValue shareInstance]

@interface UserValue : NSObject

+ (UserValue *)shareInstance;

@property (nonatomic, strong) LoginResponse *userInfo;

- (void)saveToDisk;
- (void)logoutAndClearValue;

@end
