//
//  CryptoProtocol.m
//  SecureBrowser
//
//  Created by Yury Ramanchuk on 7/7/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "CryptoProtocol.h"
#import "ApplicationConstants.h"
#import "NSURL+Additions.h"
#import "CryptoLibAdaptor.h"

@implementation CryptoProtocol


+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    return [[[request URL] scheme] caseInsensitiveCompare:FileURLScheme] == NSOrderedSame && [[[request URL] pathExtension] caseInsensitiveCompare:EncFileType] == NSOrderedSame;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    NSURL *requestURL = [[self request] URL];
    NSData *data = [NSData dataWithContentsOfURL:requestURL];
    [CryptoLibAdaptor decryptData:data];
    
    NSURLResponse *response = [[NSURLResponse alloc] initWithURL:requestURL MIMEType:[requestURL expectedMIMEType] expectedContentLength:data.length textEncodingName:nil];
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
    

    if (data) {
        [[self client] URLProtocol:self didLoadData:data];
        [[self client] URLProtocolDidFinishLoading:self];
    } else {
        [[self client] URLProtocol:self didFailWithError:[NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorFileDoesNotExist userInfo:nil]];
    }
}

- (void)stopLoading
{
    return;
}

@end
