//
//  PhoneNumSetVC.h
//  NaturalNote
//
//  Created by 李黎明 on 2017/10/26.
//  Copyright © 2017年 Liu. All rights reserved.
//

#import "NNBaseVC.h"

@interface PhoneNumSetVC : NNBaseVC

@property (nonatomic, strong) void (^didFinishedCallback)(NSString *phoneNumber);

@end
