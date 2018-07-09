//
//  NNLeftSlider.m
//  NaturalNote
//
//  Created by 李黎明 on 2018/7/3.
//  Copyright © 2018年 李黎明. All rights reserved.
//

#import "NNLeftSlider.h"
#import "NNAnimateVC.h"
#import "NNBaseNavController.h"

@implementation NNLeftSlider

static UIWindow *window_;
/**
 * 根据底部控制器展示
 */
+ (void)showWithRootViewController:(UIViewController *)rootViewController {
    window_ = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window_.backgroundColor = [UIColor clearColor];
    window_.hidden = NO;
    
    NNAnimateVC *vc = [[NNAnimateVC alloc] init];
    vc.view.backgroundColor = [UIColor clearColor];
    vc.rootViewController = rootViewController;
    NNBaseNavController *nav = [[NNBaseNavController alloc] initWithRootViewController:vc];
    nav.view.backgroundColor = [UIColor clearColor];
    window_.rootViewController = nav;
    [window_ addSubview:nav.view];
}

/**
 * 隐藏
 */
+ (void)hide {
    window_.hidden = YES;
    window_.rootViewController = nil;
    window_ = nil;
}

@end
