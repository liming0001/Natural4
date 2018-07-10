//
//  GameInfoView.h
//  NaturalNote
//
//  Created by smarter on 2018/7/10.
//  Copyright © 2018年 李黎明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameInfoView : UIView

@property (nonatomic, strong) UIImageView *gamgeIcon;//游戏图标
@property (nonatomic, strong) UILabel *gameNameLab;//游戏名称
@property (nonatomic, strong) UILabel *gameAddressLab;//游戏地址
@property (nonatomic, strong) UILabel *gameContentLab;//游戏内容
@property (nonatomic, strong) UILabel *gameDateLab;//游戏时间

@property (nonatomic, strong) void (^showGameDetailCallbackBlock)(void);

@end
