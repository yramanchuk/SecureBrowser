//
//  FileHelper.h
//  SecureBrowser
//
//  Created by Yury Ramanchuk on 7/7/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileHelper : NSObject

+ (NSArray<NSURL *> *)findAllImages;
+ (void)saveEncryptedData:(NSData *)data originalFileName:(NSString *)originalFileName;
+ (BOOL)hasEncryptedData:(NSString *)originalFileName;

@end
