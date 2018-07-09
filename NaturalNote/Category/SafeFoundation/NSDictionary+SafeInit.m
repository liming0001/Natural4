//
//  NSDictionary+SafeInit.m
//  MyShareLink
//
//  Created by Liu on 16/5/12.
//  Copyright © 2016年 com.zhilink. All rights reserved.
//

#import "NSDictionary+SafeInit.h"

@implementation NSDictionary (SafeInit)


@end

@implementation NSMutableDictionary (SafeObject)

- (void)lx_setObject:(id)anObject forKey:(id)aKey
{
    if (anObject) {
        [self setObject:anObject forKey:aKey];
    }
}

@end
