//
//  GamePoint.h
//  NaturalNote
//
//  Created by smarter on 2018/7/10.
//  Copyright © 2018年 李黎明. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKPointAnnotation.h>

@class GameResponse;
@interface GamePoint : BMKPointAnnotation

@property (nonatomic, strong) GameResponse *curCha;

@end
