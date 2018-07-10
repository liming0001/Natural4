//
//  JTDXShowView.h
//  NaturalNote
//
//  Created by smarter on 2018/7/10.
//  Copyright © 2018年 李黎明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTDXShowView : UIView

@property (nonatomic, strong) UIImageView *gamgeIcon;//植物图片
@property (nonatomic, strong) UIImageView *zhanlingIcon;
@property (nonatomic, strong) UILabel *gameNameLab;
@property (nonatomic, strong) UILabel *gameAddressLab;
@property (nonatomic, strong) UILabel *gameContentLab;
@property (nonatomic, strong) UILabel *gameDateLab;
@property (nonatomic, strong) UIButton *dakabtn;
@property (nonatomic, strong) UIButton *xiansuobtn;//线索
@property (nonatomic, strong) UIButton *xiansuoDaka;//线索打卡
@property (nonatomic, strong) NSString *curXianSuoMessage;//当前线索信息
@property (nonatomic, strong) NSMutableArray *detailA;
@property (nonatomic, strong) NSMutableArray *zlpkDataA;
@property (nonatomic, strong) NSMutableArray *endSourceA;

@end
