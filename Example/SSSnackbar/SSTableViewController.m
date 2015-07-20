//
//  SSTableViewController.m
//  SSSnackbar
//
//  Created by Sam Stone on 05/07/2015.
//  Copyright (c) 2015 Sam Stone. All rights reserved.
//

#import "SSTableViewController.h"
#import <SSSnackbar/SSSnackbar.h>

@interface SSTableViewController ()
@property (strong, nonatomic) NSMutableArray *normalExampleContents;
@property (strong, nonatomic) NSMutableArray *longRunningExampleContents;
@end

@implementation SSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _normalExampleContents = [@[@"Apples", @"Pears", @"Milk"] mutableCopy];
    _longRunningExampleContents = [@[@"Lemonade", @"Beef", @"Chicken"] mutableCopy];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setTitle:@"Shopping List"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return @"Normal Examples";
    else
        return @"Long-Running Action Examples";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return self.normalExampleContents.count;
    else
        return self.longRunningExampleContents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"item" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.textLabel.text = self.normalExampleContents[indexPath.row];
    } else {
        cell.textLabel.text = self.longRunningExampleContents[indexPath.row];
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        SSSnackbar *snackbar;
        
        if (indexPath.section == 1) {
            NSString *removedItem = self.longRunningExampleContents[indexPath.row];
            [self.longRunningExampleContents removeObjectAtIndex:indexPath.row];
            snackbar = [self snackbarForLongRunningItem:removedItem atIndexPath:indexPath];
        } else {
            NSString *removedItem = self.normalExampleContents[indexPath.row];
            [self.normalExampleContents removeObjectAtIndex:indexPath.row];
            snackbar = [self snackbarForQuickRunningItem:removedItem atIndexPath:indexPath];
        }
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [snackbar show];
    }
}

- (SSSnackbar *)snackbarForLongRunningItem:(NSString *)item atIndexPath:(NSIndexPath *)indexPath {
    NSString *snackbarMessage = [NSString stringWithFormat:@"You removed %@.", item];
    
    SSSnackbar *snackbar = [SSSnackbar snackbarWithMessage:snackbarMessage
                                                actionText:@"Undo"
                                                  duration:5
                                               actionBlock:^(SSSnackbar *sender){
                                                   //waste some time
                                                   sleep(3);
                                                   //must update the UI and dismiss the snackbar from main thread
                                                   //long running action blocks get run on background thread.
                                                   dispatch_sync(dispatch_get_main_queue(), ^{
                                                       //must avoid trying to reinsert object out of the arrays bounds
                                                       //which can happen if other objects have also been removed between this objects removal and replacement
                                                       NSIndexPath *indexPathForInsertion;
                                                       if (indexPath.row > self.longRunningExampleContents.count) {
                                                           indexPathForInsertion = [NSIndexPath indexPathForRow:self.longRunningExampleContents.count
                                                                                                      inSection:indexPath.section];
                                                       } else {
                                                           indexPathForInsertion = indexPath;
                                                       }
                                                       [self.longRunningExampleContents insertObject:item
                                                                                    atIndex:indexPathForInsertion.row];
                                                       [self.tableView insertRowsAtIndexPaths:@[indexPathForInsertion]
                                                                        withRowAnimation:UITableViewRowAnimationFade];
                                                   });
                                               }
                                            dismissalBlock:nil];
    snackbar.actionIsLongRunning = YES;
    return snackbar;
}

- (SSSnackbar *)snackbarForQuickRunningItem:(NSString *)item atIndexPath:(NSIndexPath *)indexPath {
    NSString *snackbarMessage = [NSString stringWithFormat:@"You removed %@.", item];
    
    SSSnackbar *snackbar = [SSSnackbar snackbarWithMessage:snackbarMessage
                                                actionText:@"Undo"
                                                  duration:5
                                               actionBlock:^(SSSnackbar *sender){
                                                   [self.normalExampleContents insertObject:item
                                                                                atIndex:indexPath.row];
                                                   [self.tableView insertRowsAtIndexPaths:@[indexPath]
                                                                    withRowAnimation:UITableViewRowAnimationFade];
                                               }
                                            dismissalBlock:nil];
    return snackbar;
}

@end
