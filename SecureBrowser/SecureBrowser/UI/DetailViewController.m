//
//  DetailViewController.m
//  SecureBrowser
//
//  Created by Yury Ramanchuk on 7/7/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "DetailViewController.h"
#import "CryptoLibAdaptor.h"
#import "FileHelper.h"
#import "ApplicationConstants.h"


@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *cryptoWebView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnEncrypt;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
//        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.btnEncrypt.enabled = ![FileHelper hasEncryptedData:self.detailItem.lastPathComponent];
        [self.cryptoWebView loadRequest:[NSURLRequest requestWithURL:self.detailItem]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onEncrypt:(id)sender {
    NSData *encrypted = [CryptoLibAdaptor encryptDataAtPath:self.detailItem];
    [FileHelper saveEncryptedData:encrypted originalFileName:self.detailItem.lastPathComponent];
    self.btnEncrypt.enabled = ![FileHelper hasEncryptedData:self.detailItem.lastPathComponent];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationFileEncrypted object:nil];
}

@end
