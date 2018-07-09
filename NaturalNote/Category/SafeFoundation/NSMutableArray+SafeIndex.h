//
//  NSMutableArray+SafeIndex.h
//  MyShareLink
//
//  Created by Liu on 16/5/12.
//  Copyright © 2016年 com.zhilink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (SafeIndex)

- (void)lx_addObject:(id)anObject;

@end

@interface NSArray (SafeIndex)

- (id)lx_objectAtIndex:(NSInteger)index;

@end
