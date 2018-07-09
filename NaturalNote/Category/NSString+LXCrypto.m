//
//  NSString+LXEncryption.m
//  Encryption_Demo
//
//  Created by Liu on 15/11/23.
//  Copyright © 2015年 AngryBear. All rights reserved.
//

#import "NSString+LXCrypto.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (LXCrypto)

- (NSString *)lxc_MD5String
{
    const char *cString = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cString, (CC_LONG)strlen(cString), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return hash;
}

- (NSString *)lxc_SHA1String
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(cStr, (CC_LONG)strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02X", result[i]];
    }
    return hash;
}

- (NSString *)lxc_Base64String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (NSString *)lxc_decodeFormBase64String
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)lxc_encryptAESStringWithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));

    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    size_t dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    char *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *da = [NSData dataWithBytes:buffer length:numBytesEncrypted];
        NSString *cStr = [[NSString alloc] initWithData:da encoding:NSMacOSRomanStringEncoding];
        return cStr;
    }
    
    free(buffer);
    return nil;
}

- (NSString *)lxc_decryptAESStringWithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    const char *data = [self cStringUsingEncoding:NSMacOSRomanStringEncoding];
    size_t bufferSize = sizeof(data) + kCCBlockSizeAES128;
    char *buffer = malloc(bufferSize);

    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL,
                                          data, 2*sizeof(data),
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSString *decryptStr = [[NSString alloc] initWithBytes:buffer length:numBytesDecrypted encoding:NSUTF8StringEncoding];
        return decryptStr;
    }
    
    free(buffer);
    return nil;
}

@end
