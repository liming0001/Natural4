//
//  MarkTextField.m
//  NaturalNote
//
//  Created by Liu on 16/9/17.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import "MarkTextField.h"

@implementation MarkTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.mark];
        [self addSubview:self.textField];
        
        [self.mark mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(15/2, 15/2));
        }];
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mark.mas_right).offset(6);
            make.centerY.equalTo(self);
            make.right.equalTo(self);
            make.height.mas_equalTo(35);
        }];
    }
    return self;
}

#pragma mark - Getter
- (UIImageView *)mark
{
    if (!_mark) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [UIImage imageNamed:@"icon_asterisk"];
        _mark = imageView;
    }
    return _mark;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [self configTextField];
    }
    return _textField;
}

- (UITextField *)configTextField
{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.backgroundColor = [UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:12];
    textField.textColor = [UIColor colorWithHexRGB:0x333333];
    textField.background = [[UIImage imageNamed:@"bt_white_default"] stretchableImageWithLeftCapWidth:8 topCapHeight:8];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 35)];
    imageView.backgroundColor = [UIColor clearColor];
    textField.leftView = imageView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    return textField;
}

@end
