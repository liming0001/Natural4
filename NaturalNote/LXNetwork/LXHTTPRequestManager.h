//
//  LXHTTPRequestManager.h
//  ProjectSource_Demo
//
//  Created by Liu on 16/3/29.
//  Copyright © 2016年 AngryBear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXBaseRequest.h"

@interface LXHTTPRequestManager : NSObject

+ (LXHTTPRequestManager *)manager;

- (void)addRequest:(LXBaseRequest *)request;

- (void)removeRequest:(LXBaseRequest *)request;

@end
