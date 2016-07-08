//
//  NSURL+Additions.m
//  SecureBrowser
//
//  Created by Yury Ramanchuk on 7/8/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "NSURL+Additions.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ApplicationConstants.h"

@implementation NSURL (Additions)

// Infer the MIME type of the resource from its path extension
// Source: http://stackoverflow.com/a/9802467/452816
- (NSString *)expectedMIMEType
{
    NSString *fileName = [self lastPathComponent];
    while ([fileName.pathExtension caseInsensitiveCompare:EncFileType] == NSOrderedSame) {
        fileName = fileName.stringByDeletingPathExtension;
    }
    
    CFStringRef type = NULL;
    {
        CFStringRef pathExtension = (__bridge_retained CFStringRef)fileName.pathExtension;
        
        type = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension, NULL);
        
        if (pathExtension != NULL) {
            CFRelease(pathExtension), pathExtension = NULL;
        }
    }
    
    NSString *MIMEType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass(type, kUTTagClassMIMEType);
    
    if (type != NULL) {
        CFRelease(type), type = NULL;
    }
    
    return MIMEType;
}

@end
