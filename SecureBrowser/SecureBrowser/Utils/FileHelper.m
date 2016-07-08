//
//  FileHelper.m
//  SecureBrowser
//
//  Created by Yury Ramanchuk on 7/7/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "FileHelper.h"
#import "ApplicationConstants.h"

@implementation FileHelper

+ (NSArray<NSURL *> *)findAllImages {
    NSMutableArray *images = [NSMutableArray new];
    [images addObjectsFromArray:[self findAllImagesIn:[[NSBundle mainBundle] bundleURL]]];

    NSArray *paths = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsURL = [paths lastObject];
    [images addObjectsFromArray:[self findAllImagesIn:documentsURL]];
    
    
    return [images copy];
}

//    https://developer.apple.com/reference/foundation/nsfilemanager/1409571-enumeratoraturl
+ (NSArray<NSURL *> *)findAllImagesIn:(NSURL *)directoryURL {
    NSFileManager *localFileManager= [[NSFileManager alloc] init];
    NSDirectoryEnumerator *directoryEnumerator =
    [localFileManager enumeratorAtURL:directoryURL
           includingPropertiesForKeys:@[NSURLNameKey, NSURLIsDirectoryKey]
                              options:NSDirectoryEnumerationSkipsHiddenFiles
                         errorHandler:nil];
    
    NSMutableArray<NSURL *> *mutableFileURLs = [NSMutableArray array];
    for (NSURL *fileURL in directoryEnumerator) {
        NSNumber *isDirectory = nil;
        [fileURL getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:nil];
        
        NSString *name = nil;
        [fileURL getResourceValue:&name forKey:NSURLNameKey error:nil];
        
        if (![isDirectory boolValue] &&
            ([name.pathExtension caseInsensitiveCompare:EncFileType] == NSOrderedSame ||
                   [name.pathExtension caseInsensitiveCompare:PngFileType] == NSOrderedSame)) {
            [mutableFileURLs addObject:fileURL];
        }
    }
    
    return [mutableFileURLs copy];
    
}

+ (void)saveEncryptedData:(NSData *)data originalFileName:(NSString *)originalFileName {
    NSString *path = [self getEncryptedPath:originalFileName];
    [data writeToFile:path atomically:YES];
    
}

+ (BOOL)hasEncryptedData:(NSString *)originalFileName {
    NSString *path = [self getEncryptedPath:originalFileName];
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (NSString *)getEncryptedPath:(NSString *)originalFileName {
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", originalFileName, EncFileType]];

    return fullPath;
}

@end
