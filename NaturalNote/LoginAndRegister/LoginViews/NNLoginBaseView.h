//
//  NNLoginBaseView.h
//  NaturalNote
//
//  Created by Liu on 16/9/17.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import "TPKeyboardAvoidingScrollView.h"

@interface NNLoginBaseView : TPKeyboardAvoidingScrollView

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) UIButton *leftNavigationButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *rightNavigationButton;

@end
