//
//  UIColor+LXCustomColor.h
//  ProjectSource_Demo
//
//  Created by Liu on 15/11/27.
//  Copyright © 2015年 AngryBear. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBAlpha(r, g, b, a)     ([UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)])
#define HexRGB(rgbValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0])
@interface UIColor (LXCustomColor)

+ (UIColor *)colorWithHexString:(NSString *)hex;
/**
 *  根据16进制RGB值，获取UIColor
 */
+ (UIColor *)colorWithHexRGB:(NSInteger)rgbValue;
+ (UIColor *)colorWithHexRGB:(NSInteger)rgbValue alpha:(CGFloat)alpha;

+ (UIColor *)appStyleColor;
+ (UIColor *)grayBG;
+ (UIColor *)graylineColor;

// 0x323232
+ (UIColor *)titleTextColor;
// 0xfd493b
+ (UIColor *)priceTextColor;

@end


