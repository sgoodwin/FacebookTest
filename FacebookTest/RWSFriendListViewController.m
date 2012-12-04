//
//  RWSFriendListViewController.m
//  FacebookTest
//
//  Created by Samuel Goodwin on 12/4/12.
//  Copyright (c) 2012 Roundwall Software. All rights reserved.
//

#import "RWSFriendListViewController.h"
#import "RWSFriendList.h"
#import "RWSFriend.h"
#import "RWSFriendCell.h"
#import "RWSImageManager.h"

@interface RWSFriendListViewController()
@property (nonatomic, strong) RWSFriendList *friendList;
@property (nonatomic, strong) RWSImageManager *imageManager;
@end

static NSString *const CellIdentifier = @"Cell";

@implementation RWSFriendListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.imageManager = [[RWSImageManager alloc] init];
    [self.tableView registerClass:[RWSFriendCell class] forCellReuseIdentifier:CellIdentifier];

    self.friendList = [[RWSFriendList alloc] init];
    [self.friendList addObserver:self forKeyPath:@"friends" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
    [self.friendList update];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.friendList friendCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    RWSFriend *friend = [self.friendList friendAtIndex:indexPath.row];
    cell.textLabel.text = friend.firstName;
    cell.detailTextLabel.text = friend.lastName;
    cell.imageView.image = [self.imageManager imageForIndexPath:indexPath];
    return cell;
}

@end
