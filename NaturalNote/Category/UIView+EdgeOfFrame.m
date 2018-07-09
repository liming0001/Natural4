//
//  UIView+EdgeOfFrame.m
//  ProjectSource_Demo
//
//  Created by Liu on 16/3/21.
//  Copyright © 2016年 AngryBear. All rights reserved.
//

#import "UIView+EdgeOfFrame.h"

@implementation UIView (EdgeOfFrame)

- (CGFloat)f_left
{
    return self.frame.origin.x;
}

- (void)setF_left:(CGFloat)f_left
{
    CGRect frame = self.frame;
    frame.origin.x = f_left;
    self.frame = frame;
}

- (CGFloat)f_right
{
    return self.f_left + self.f_width;
}

- (void)setF_right:(CGFloat)f_right
{
    CGRect frame = self.frame;
    frame.origin.x = f_right - self.f_width;
    self.frame = frame;
}

- (CGFloat)f_top
{
    return self.frame.origin.y;
}

- (void)setF_top:(CGFloat)f_top
{
    CGRect frame = self.frame;
    frame.origin.y = f_top;
    self.frame = frame;
}

- (CGFloat)f_bottom
{
    return self.f_top + self.f_height;
}

- (void)setF_bottom:(CGFloat)f_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = f_bottom - self.f_height;
    self.frame = frame;
}

- (CGFloat)f_width
{
    return self.frame.size.width;
}

- (void)setF_width:(CGFloat)f_width
{
    CGRect frame = self.frame;
    frame.size.width = f_width;
    self.frame = frame;
}

- (CGFloat)f_height
{
    return self.frame.size.height;
}

- (void)setF_height:(CGFloat)f_height
{
    CGRect frame = self.frame;
    frame.size.height = f_height;
    self.frame = frame;
}

- (void)setF_centerX:(CGFloat)f_centerX
{
    CGPoint center = self.center;
    center.x = f_centerX;
    self.center = center;
}

- (CGFloat)f_centerX
{
    return self.center.x;
}

- (void)setF_centerY:(CGFloat)f_centerY
{
    CGPoint center = self.center;
    center.y = f_centerY;
    self.center = center;
}

- (CGFloat)f_centerY
{
    return self.center.y;
}

- (void)setF_size:(CGSize)f_size {
    CGRect frame = self.frame;
    frame.size = f_size;
    self.frame = frame;
}

- (CGSize)f_size {
    return self.frame.size;
}

@end
