//
//  GameListRequest.h
//  NaturalNote
//
//  Created by smarter on 2018/7/10.
//  Copyright © 2018年 李黎明. All rights reserved.
//

#import "LXBaseRequest.h"

@interface GameListRequest : LXBaseRequest

@property (nonatomic, strong) NSString *IsQueryAll;    //是否查询所有的游戏列表

@end
