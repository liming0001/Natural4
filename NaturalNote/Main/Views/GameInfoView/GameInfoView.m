//
//  GameInfoView.m
//  NaturalNote
//
//  Created by smarter on 2018/7/10.
//  Copyright © 2018年 李黎明. All rights reserved.
//

#import "GameInfoView.h"

@implementation GameInfoView

- (UIImageView *)gamgeIcon{
    if (!_gamgeIcon) {
        _gamgeIcon = [[UIImageView alloc]initWithFrame:CGRectMake(6, 8, 110, 108)];
        _gamgeIcon.image = [UIImage imageNamed:@"pic_loading_v"];
    }
    return _gamgeIcon;
}

- (UILabel *)gameNameLab{
    if (!_gameNameLab) {
        _gameNameLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_gamgeIcon.frame)+5, 8, ScreenWidth- 30-CGRectGetMaxX(_gamgeIcon.frame)-5-5-14, 24)];
        _gameNameLab.textColor  = [UIColor colorWithHexRGB:0x333333 alpha:1];
        _gameNameLab.font = [UIFont systemFontOfSize:15];
    }
    return _gameNameLab;
}

- (UILabel *)gameAddressLab{
    if (!_gameAddressLab) {
        _gameAddressLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_gamgeIcon.frame)+5, CGRectGetMaxY(_gameNameLab.frame), ScreenWidth- 30-CGRectGetMaxX(_gamgeIcon.frame)-5-5, 20)];
        _gameAddressLab.textColor  = [UIColor colorWithHexRGB:0x666666 alpha:1];
        _gameAddressLab.font = [UIFont systemFontOfSize:12];
    }
    return _gameAddressLab;
}

- (UILabel *)gameContentLab{
    if (!_gameContentLab) {
        _gameContentLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_gamgeIcon.frame)+5, CGRectGetMaxY(_gameAddressLab.frame), ScreenWidth- 30-CGRectGetMaxX(_gamgeIcon.frame)-6-5, 40)];
        _gameContentLab.numberOfLines = 0;
        _gameContentLab.textColor  = [UIColor colorWithHexRGB:0x333333 alpha:1];
        _gameContentLab.font = [UIFont systemFontOfSize:12];
    }
    return _gameContentLab;
}

- (UILabel *)gameDateLab{
    if (!_gameDateLab) {
        _gameDateLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_gamgeIcon.frame)+5, 90, ScreenWidth- 30-CGRectGetMaxX(_gamgeIcon.frame)-5-5, 30)];
        _gameDateLab.textColor  = [UIColor colorWithHexRGB:0x999999 alpha:1];
        _gameDateLab.font = [UIFont systemFontOfSize:10];
    }
    return _gameDateLab;
}

-(id)initWithFrame:(CGRect)frame {
    if ( !(self = [super initWithFrame:frame]) ) return nil;
    [self setup];
    return self;
}

- (void)setup{
    [self addSubview:self.gamgeIcon];
    [self addSubview:self.gameNameLab];
    [self addSubview:self.gameAddressLab];
    [self addSubview:self.gameContentLab];
    [self addSubview:self.gameDateLab];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_gamgeIcon.frame)+5, 90, ScreenWidth- 30-CGRectGetMaxX(_gamgeIcon.frame)-6, 1)];
    line.backgroundColor = [UIColor colorWithHexRGB:0xeeeeee alpha:1];
    [self addSubview:line];

    UIImageView *arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth- 30-10-7, 99, 7, 12)];
    arrowImg.image = [UIImage imageNamed:@"icon_list_arrow"];
    [self addSubview:arrowImg];

    UIButton *detailbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    detailbtn.frame  = CGRectMake(0, 0, ScreenWidth- 30, 125);
    [detailbtn addTarget:self action:@selector(showGameDetail) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:detailbtn];

    UIButton *closebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closebtn.frame  = CGRectMake(ScreenWidth- 30-14, 0, 14, 14);
    [closebtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [closebtn addTarget:self action:@selector(closeDetailInfoShow) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closebtn];
}

- (void)closeDetailInfoShow{
    [self removeFromSuperview];
}

- (void)dealloc{
    self.gamgeIcon = nil;
    self.gameNameLab = nil;
    self.gameAddressLab = nil;
    self.gameContentLab = nil;
    self.gameDateLab = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end