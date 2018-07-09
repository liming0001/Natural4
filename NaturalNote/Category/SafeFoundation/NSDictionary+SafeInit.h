//
//  NSDictionary+SafeInit.h
//  MyShareLink
//
//  Created by Liu on 16/5/12.
//  Copyright © 2016年 com.zhilink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SafeInit)



@end

@interface NSMutableDictionary (SafeObject)

- (void)lx_setObject:(id)anObject forKey:(id)aKey;

@end
