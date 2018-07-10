//
//  YWRoundAnnotationView.h
//  YWLJMapView
//
//  Created by NeiQuan on 16/7/27.
//  Copyright © 2016年 Mr-yuwei. All rights reserved.
//

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

@class GameResponse;
@interface YWRoundGameAnnotationView : BMKAnnotationView
@property (nonatomic, strong) GameResponse *gameSource;

- (void)showInfoWithPointInfo:(GameResponse *)game;

@end

