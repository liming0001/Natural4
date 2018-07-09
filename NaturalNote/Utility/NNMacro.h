//
//  NNMacro.h
//  NaturalNote
//
//  Created by smarter on 2018/7/3.
//  Copyright © 2018年 李黎明. All rights reserved.
//

#ifndef NNMacro_h
#define NNMacro_h

///------------
/// UIScreen
///------------
#define ScreenWidth [UIScreen mainScreen].bounds.size.width //屏幕宽
#define ScreenHeight [UIScreen mainScreen].bounds.size.height //屏幕高
#define ScreenWidthScale (ScreenWidth/320) //屏幕宽比例

//百度地图Key
#define baidu_API_Dis  @"ronu81OLNlRxcxHczX8rbxmehSuBqR8n"
#define baidu_API_Dev  @"56GdW4FGwHDnskp8AscXyAIdKsQumc8F"

//weixin
#define wxAppID         @"wx00fce9b0bf801b42"
#define wxAppSecret     @"b59e576244afbd1ec82850a58072f0c8"
#define WXPacket_State  @"ziranbiji"

//当前版本号
#define current_version  @"V2.1.9"

///------------
/// AppDelegate
///------------
#define NNSharedAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

///------------
/// Log
///------------
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

#define JPushAppKey_Normal    @"cfa77ac590934aa0fbfa3d64"
#define JPushAppSecrt_Normal  @"67daa15060a74ea0915d6015"

///------------
/// DeviceType
///------------
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6_PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#endif /* NNMacro_h */
