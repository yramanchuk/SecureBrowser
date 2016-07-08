//
//  CryptoLibAdaptor.m
//  SecureBrowser
//
//  Created by Yury Ramanchuk on 7/7/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "CryptoLibAdaptor.h"
#import "CryptoLib.h"

#define ENCRYPTION_KEY @"1"

@implementation CryptoLibAdaptor

+ (NSData *)encryptDataAtPath:(NSURL *)pathUrl {
    NSData *data = [NSData dataWithContentsOfURL:pathUrl];
    [self cryptData:data];
    
    return data;
}

+ (void)decryptData:(NSData *)data {

    [self cryptData:data];
}


+ (void)cryptData:(NSData *)data {
    char *dataPtr = (char *)[data bytes];
    
    NSString *key = ENCRYPTION_KEY;
    NSData* keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    const char *keyDataPtr = (const char *)[keyData bytes];
    
    xor_crypt(keyDataPtr, keyData.length, dataPtr, data.length);
}

@end
