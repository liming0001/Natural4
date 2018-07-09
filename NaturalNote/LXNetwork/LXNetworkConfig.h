//
//  LXNetworkConfig.h
//  ProjectSource_Demo
//
//  Created by Liu on 16/3/29.
//  Copyright © 2016年 AngryBear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXNetworkConfig : NSObject

+ (LXNetworkConfig *)defaultConfig;

@property (strong, nonatomic) NSString *baseURL;

- (void)addCookie;

@end
