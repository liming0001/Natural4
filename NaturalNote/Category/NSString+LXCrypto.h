//
//  NSString+LXEncryption.h
//  Encryption_Demo
//
//  Created by Liu on 15/11/23.
//  Copyright © 2015年 AngryBear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LXCrypto)

- (NSString *)lxc_MD5String;

- (NSString *)lxc_SHA1String;

- (NSString *)lxc_Base64String;

- (NSString *)lxc_decodeFormBase64String;

- (NSString *)lxc_encryptAESStringWithKey:(NSString *)key;

- (NSString *)lxc_decryptAESStringWithKey:(NSString *)key;

@end
