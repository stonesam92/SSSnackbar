//
//  SSTableViewController.m
//  SSSnackbar
//
//  Created by Sam Stone on 05/07/2015.
//  Copyright (c) 2015 Sam Stone. All rights reserved.
//

#import "SSTableViewController.h"
#import <SSSnackbar/SSSnackBar.h>

@interface SSTableViewController ()
@property (strong, nonatomic) NSMutableArray *tableViewContents;
@property (strong, nonatomic) NSString *lastRemovedElement;
@property (assign, nonatomic) NSInteger lastRemovedIndex;
@end

@implementation SSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableViewContents = [@[@"Apples", @"Pears", @"Milk", @"Lemonade", @"Beef", @"Chicken"] mutableCopy];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setTitle:@"Shopping List"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewContents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"item" forIndexPath:indexPath];
    cell.textLabel.text = self.tableViewContents[indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSInteger row = indexPath.row;
        self.lastRemovedIndex = row;
        self.lastRemovedElement = self.tableViewContents[row];
        [self.tableViewContents removeObjectAtIndex:row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSString *snackbarMessage = [NSString stringWithFormat:@"You removed %@.", self.lastRemovedElement];
        SSSnackBar *snackbar = [[SSSnackBar alloc] initWithMessage:snackbarMessage
                                                        actionText:@"Undo"
                                                          duration:5
                                                       actionBlock:^(SSSnackBar *sender) {
                                                           [self.tableViewContents insertObject:self.lastRemovedElement
                                                                                        atIndex:self.lastRemovedIndex];
                                                           [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.lastRemovedIndex inSection:0]]
                                                                            withRowAnimation:UITableViewRowAnimationFade];
                                                           
                                                       }
                                                    dismissalBlock:nil];
        [snackbar show];
    }
}

@end
