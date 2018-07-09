//
//  NSMutableArray+SafeIndex.m
//  MyShareLink
//
//  Created by Liu on 16/5/12.
//  Copyright © 2016年 com.zhilink. All rights reserved.
//

#import "NSMutableArray+SafeIndex.h"

@implementation NSMutableArray (SafeIndex)

- (void)lx_addObject:(id)anObject
{
    if (anObject) {
        [self addObject:anObject];
    }
}

@end


@implementation NSArray (SafeIndex)

- (id)lx_objectAtIndex:(NSInteger)index
{
    if (self.count == 0) {
        return nil;
    }
    if (index >= self.count || index < 0) {
        return nil;
    }
    
    return [self objectAtIndex:index];
}

@end
