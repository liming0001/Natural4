//
//  NNLeftSlider.h
//  NaturalNote
//
//  Created by 李黎明 on 2018/7/3.
//  Copyright © 2018年 李黎明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NNLeftSlider : NSObject

/**
 * 根据底部控制器展示
 */
+ (void)showWithRootViewController:(UIViewController *)rootViewController;

/**
 * 隐藏
 */
+ (void)hide;

@end
