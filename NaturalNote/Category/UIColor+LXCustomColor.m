//
//  UIColor+LXCustomColor.m
//  ProjectSource_Demo
//
//  Created by Liu on 15/11/27.
//  Copyright © 2015年 AngryBear. All rights reserved.
//

#import "UIColor+LXCustomColor.h"

@implementation UIColor (LXCustomColor)

+ (UIColor *)colorWithHexString:(NSString *)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


+ (UIColor *)colorWithHexRGB:(NSInteger)rgbValue
{
    return [self colorWithHexRGB:rgbValue alpha:1];
}

+ (UIColor *)colorWithHexRGB:(NSInteger)rgbValue alpha:(CGFloat)alpha
{
    return  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpha];
}

+ (UIColor *)appStyleColor
{
    return [UIColor colorWithHexRGB:0x01c0d8];
}

+ (UIColor *)graylineColor
{
    return HexRGB(0xdadada);
}

+ (UIColor *)grayBG
{
    return HexRGB(0xeeeeee);
}

+ (UIColor *)titleTextColor {
    return HexRGB(0x323232);
}

+ (UIColor *)priceTextColor {
    return HexRGB(0xfd493b);
}

@end
