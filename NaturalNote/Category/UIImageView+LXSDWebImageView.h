//
//  UIImageView+LXSDWebImageView.h
//  MyShareLink
//
//  Created by Liu on 16/5/20.
//  Copyright © 2016年 com.zhilink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface UIImageView (LXSDWebImageView)

- (void)setImageWithURLString:(NSString *)url placeholder:(UIImage *)image;

- (void)setImageWithAuthenticateURL:(NSString *)url placeholder:(UIImage *)image;

- (void)setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options;

@end
