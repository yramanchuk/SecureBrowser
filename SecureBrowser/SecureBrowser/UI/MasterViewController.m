//
//  MasterViewController.m
//  SecureBrowser
//
//  Created by Yury Ramanchuk on 7/6/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ApplicationConstants.h"

#import "FileHelper.h"

@interface MasterViewController ()

@property NSArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.objects = [[NSMutableArray alloc] initWithArray:[FileHelper findAllImages]];
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onFileEncrypted:) name:kNotificationFileEncrypted object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSURL *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSURL *object = self.objects[indexPath.row];
    cell.textLabel.text = [object lastPathComponent];
    return cell;
}


- (void)onFileEncrypted:(NSNotification *)notification {
    self.objects = [[NSMutableArray alloc] initWithArray:[FileHelper findAllImages]];
    [self.tableView reloadData];
}



@end
