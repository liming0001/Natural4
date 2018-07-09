//
//  DoubleImageButton.m
//  NaturalNote
//
//  Created by Liu on 16/9/17.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import "GenderSelectView.h"

@implementation GenderSelectView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.male];
        [self addSubview:self.female];
        
        [self.male mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(@0);
            make.size.mas_equalTo(CGSizeMake(40, 18));
        }];
        
        [self.female mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.mas_equalTo(@0);
            make.size.mas_equalTo(CGSizeMake(40, 18));
        }];
        
        self.male.isChecked = YES;
        [self.male addTarget:self action:@selector(buttonOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.female addTarget:self action:@selector(buttonOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)buttonOnClicked:(DoubleImageButton *)btn {
    if (!btn.isChecked) {
        self.male.isChecked = !self.male.isChecked;
        self.female.isChecked = !self.female.isChecked;
        self.gender = self.male.isChecked ? @1 : @2;
    }
}

- (void)setGender:(NSNumber *)gender {
    if (gender.integerValue == 2) {
        [self buttonOnClicked:self.female];
    }
    else {
        [self buttonOnClicked:self.male];
    }
}

#pragma mark - Getter
- (DoubleImageButton *)male {
    if (!_male) {
        _male = [[DoubleImageButton alloc] initWithFrame:CGRectZero];
        _male.rightImage.image = [UIImage imageNamed:@"icon_nan"];
        _male.isChecked = YES;
    }
    return _male;
}

- (DoubleImageButton *)female {
    if (!_female) {
        _female = [[DoubleImageButton alloc] initWithFrame:CGRectZero];
        _female.rightImage.image = [UIImage imageNamed:@"icon_nv"];
    }
    return _female;
}

@end

@implementation DoubleImageButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.leftImage];
        [self addSubview:self.rightImage];
        
        [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(@0);
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];
        
        [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.mas_equalTo(@0);
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];
        
//        @weakify(self);
//        [RACObserve(self, isChecked) subscribeNext:^(id x) {
//            @strongify(self);
//            self.leftImage.image = self.isChecked ? [UIImage imageNamed:@"icon_box_check"] : [UIImage imageNamed:@"icon_box_nocheck"];
//        }];
    }
    return self;
}

#pragma mark - Getter
- (UIImageView *)leftImage {
    if (!_leftImage) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.contentMode = UIViewContentModeCenter;
        _leftImage = imageView;
    }
    return _leftImage;
}

- (UIImageView *)rightImage {
    if (!_rightImage) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.contentMode = UIViewContentModeCenter;
        _rightImage = imageView;
    }
    return _rightImage;
}

@end
