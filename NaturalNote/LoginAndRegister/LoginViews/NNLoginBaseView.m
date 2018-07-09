//
//  NNLoginBaseView.m
//  NaturalNote
//
//  Created by Liu on 16/9/17.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import "NNLoginBaseView.h"

@implementation NNLoginBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexRGB:0x48B3D0];
        [self addSubview:self.background];
        [self addSubview:self.contentView];
        [self addSubview:self.leftNavigationButton];
        [self addSubview:self.titleLabel];
        [self addSubview:self.rightNavigationButton];
        self.rightNavigationButton.hidden = YES;
        
        [self.background mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(-20);
            make.left.right.mas_equalTo(0);
            make.size.mas_equalTo([UIScreen mainScreen].bounds.size);
        }];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
            make.centerX.equalTo(self);
            make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height + 100);
        }];
        
        [self.leftNavigationButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@10);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.mas_equalTo(@10);
            make.size.mas_equalTo(CGSizeMake(200, 20));
        }];
        
        [self.rightNavigationButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
    }
    return self;
}

#pragma mark - Getter
- (UIImageView *)background {
    if (!_background) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.backgroundColor = [UIColor whiteColor];
        UIImage *image = [UIImage imageNamed:@"Login_bg_Normal"];
        imageView.image = image;
        _background = imageView;
    }
    return _background;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UIButton *)leftNavigationButton {
    if (!_leftNavigationButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        button.backgroundColor = [UIColor clearColor];
        [button setImage:[UIImage imageNamed:@"icon_nav_back"] forState:UIControlStateNormal];
        _leftNavigationButton = button;
    }
    return _leftNavigationButton;
}

- (UIButton *)rightNavigationButton {
    if (!_rightNavigationButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        button.backgroundColor = [UIColor clearColor];
        [button setImage:[UIImage imageNamed:@"nav_icon_search"] forState:UIControlStateNormal];
        _rightNavigationButton = button;
    }
    return _rightNavigationButton;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:17];
        label.textAlignment = NSTextAlignmentCenter;
        _titleLabel = label;
    }
    return _titleLabel;
}

@end
