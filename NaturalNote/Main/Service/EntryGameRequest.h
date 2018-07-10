//
//  EntryGameRequest.h
//  NaturalNote
//
//  Created by 李黎明 on 2017/7/20.
//  Copyright © 2017年 Liu. All rights reserved.
//

#import "LXBaseRequest.h"

@interface EntryGameRequest : LXBaseRequest

@property (nonatomic, strong) NSString *gameCode;       //游戏编码
@property (nonatomic, strong) NSString *zuheCode;        //组合编码
@property (nonatomic, strong) NSString *joinOrExit;        //加入还是退出（JOIN 加入 ，EXIT  退出）

@end
