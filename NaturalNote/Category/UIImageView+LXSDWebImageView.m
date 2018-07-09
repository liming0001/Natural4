//
//  UIImageView+LXSDWebImageView.m
//  MyShareLink
//
//  Created by Liu on 16/5/20.
//  Copyright © 2016年 com.zhilink. All rights reserved.
//

#import "UIImageView+LXSDWebImageView.h"

@implementation UIImageView (LXSDWebImageView)

- (void)setImageWithURLString:(NSString *)url placeholder:(UIImage *)image {
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:image];
}

- (void)setImageWithAuthenticateURL:(NSString *)url placeholder:(UIImage *)image
{
    url = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)url, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:image];
}

- (void)setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options {
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder options:options];
}

@end
