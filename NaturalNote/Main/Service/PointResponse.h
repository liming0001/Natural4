//
//  PointResponse.h
//  NaturalNote
//
//  Created by 李黎明 on 2017/7/24.
//  Copyright © 2017年 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PointResponse : NSObject

@property (nonatomic, copy) NSString * gameId;//游戏Id
@property (nonatomic, copy) NSString * pointId;//游戏点id
@property (nonatomic, copy) NSString * residueEnergyValue;//我的剩余能量值
@property (nonatomic, copy) NSString * myPutEnergyValue;//我在该游戏点投入的能量值
@property (nonatomic, copy) NSString * myGroupEnergyValue;//我所在的分组在该游戏点投入的总能量值
@property (nonatomic, copy) NSString * pointName;//游戏点名称，【没有占领时为空】
@property (nonatomic, copy) NSString * groupId;//当前占领的分组id【没有占领时为空】
@property (nonatomic, copy) NSString * groupName;//当前占领的分组名称【没有占领时为空】
@property (nonatomic, copy) NSString * countEnergyValue;//该分组在当前游戏点投入的总能量值【没有占领时为空】
@property (nonatomic, copy) NSString * clockInTime;//占领打卡的时间
@property (nonatomic, copy) NSString * type;//占领还是取消占领。ZL占领QXZL 取消占领

@property (nonatomic, copy) NSString * latitude;
@property (nonatomic, copy) NSString * longitude;
@property (nonatomic, copy) NSString * plantId;
@property (nonatomic, copy) NSString * plantFiristImg;
@property (nonatomic, copy) NSString * plantDesc;
@property (nonatomic, copy) NSString * clueDetail;//线索
@property (nonatomic, copy) NSString * order;
@property (nonatomic, copy) NSString * gameOrder;
@property (nonatomic, copy) NSString * isEndPoint;
@property (nonatomic, copy) NSString * groupCode;
@property (nonatomic, copy) NSString * groupColor;

@property (nonatomic, assign) BOOL isFinished;//是否已打卡或者已被占领
@property (nonatomic, assign) BOOL isSelected;//是否被选中
@property (nonatomic, assign) BOOL isZhanling;//是否被占领
@property (nonatomic, assign) int isZLPK;//是否占领PK

@end
