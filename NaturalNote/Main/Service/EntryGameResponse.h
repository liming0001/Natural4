//
//  EntryGameResponse.h
//  NaturalNote
//
//  Created by 李黎明 on 2017/7/20.
//  Copyright © 2017年 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntryGameResponse : NSObject

@property (nonatomic, copy) NSString * success;
@property (nonatomic, copy) NSString * desc;
@property (nonatomic, copy) NSString * gameId;
@property (nonatomic, copy) NSString * gameCode;
@property (nonatomic, copy) NSString * createTime;
@property (nonatomic, copy) NSString * gameName;
@property (nonatomic, copy) NSString * gameAddr;
@property (nonatomic, copy) NSString * refereeUserIds;
@property (nonatomic, copy) NSString * gameImageUrl;
@property (nonatomic, copy) NSString * gameDesc;
@property (nonatomic, copy) NSString * maxUsers;
@property (nonatomic, copy) NSString * maxEnergy;
@property (nonatomic, copy) NSString * maxplayTime;
@property (nonatomic, copy) NSString * gameStatus;
@property (nonatomic, copy) NSString * gameType;
@property (nonatomic, copy) NSString * gamePointOrderType;
@property (nonatomic, copy) NSString * latitude;
@property (nonatomic, copy) NSString * longitude;
@property (nonatomic, copy) NSArray * gamePoints;




@end
