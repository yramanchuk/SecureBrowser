//
//  CryptoLibAdaptor.h
//  SecureBrowser
//
//  Created by Yury Ramanchuk on 7/7/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CryptoLibAdaptor : NSObject

+ (NSData *)encryptDataAtPath:(NSURL *)pathUrl;
+ (void)decryptData:(NSData *)data;

@end
