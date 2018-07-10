//
//  EntryGameRequest.m
//  NaturalNote
//
//  Created by 李黎明 on 2017/7/20.
//  Copyright © 2017年 Liu. All rights reserved.
//

#import "EntryGameRequest.h"

@implementation EntryGameRequest

- (NSString *)urlString {
    return @"/naturenote/spring/game/joinGame";
}

- (NSDictionary *)requestParameters {
    return @{@"gameCode" : self.gameCode ? self.gameCode : @"",
             @"groupCode" : self.zuheCode ? self.zuheCode : @"",
             @"joinOrExit" : self.joinOrExit ? self.joinOrExit : @""};
}

@end
