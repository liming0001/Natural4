//
//  CommonUtility.h
//  NaturalNote
//
//  Created by 李黎明 on 2017/5/25.
//  Copyright © 2017年 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CommonUtility : NSObject

@property (nonatomic, strong) NSArray *cPlants;

@property (nonatomic, strong) NSString *locationAddress;
@property (nonatomic, strong) NSString *registrationId;//极光推送注册id
@property (nonatomic, assign) BOOL isCaipan;//判断当前游戏是否为裁判角色
@property (nonatomic, assign) BOOL isLoginAgain;//判断是否重新登录
@property (nonatomic, assign) int curPointOrder;//当前选择植物点标签

@property (nonatomic, assign) BOOL isSetDistance;
@property (nonatomic, assign) BOOL openFlateChoose;//开启植物判断

@property (nonatomic) CLLocationCoordinate2D userCoordinate;

+ (CommonUtility *)sharedManager;

+ (NSString *) ReturnBlankString:(NSString *)string;

+(double)distanceBetweenOrderBy:(double)lat1 :(double)lat2 :(double)lng1 :(double)lng2;

@end
