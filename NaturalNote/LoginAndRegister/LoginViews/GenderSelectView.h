//
//  DoubleImageButton.h
//  NaturalNote
//
//  Created by Liu on 16/9/17.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DoubleImageButton;
@interface GenderSelectView : UIView

@property (nonatomic, strong) DoubleImageButton *male;
@property (nonatomic, strong) DoubleImageButton *female;
@property (nonatomic, strong) NSNumber *gender; //@1 男， @2 女

@end

@interface DoubleImageButton : UIButton

@property (nonatomic, strong) UIImageView *leftImage;
@property (nonatomic, strong) UIImageView *rightImage;

@property (nonatomic, assign) BOOL isChecked;

@end
