//
//  GameResponse.h
//  NaturalNote
//
//  Created by smarter on 2018/7/10.
//  Copyright © 2018年 李黎明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResponse : NSObject

@property (nonatomic, copy) NSString * gameId;
@property (nonatomic, copy) NSString * gameCode;
@property (nonatomic, copy) NSString * pointId;
@property (nonatomic, copy) NSString * gameName;
@property (nonatomic, copy) NSString * gameAddr;
@property (nonatomic, copy) NSString * refereeUserIds;
@property (nonatomic, copy) NSString * createDate;
@property (nonatomic, copy) NSString * gameImageUrl;
@property (nonatomic, copy) NSString * gameDesc;
@property (nonatomic, copy) NSString * gameType;
@property (nonatomic, copy) NSString * gameStatus;
@property (nonatomic, copy) NSString * gamePointOrderType;
@property (nonatomic, copy) NSString * latitude;
@property (nonatomic, copy) NSString * longitude;

@end
