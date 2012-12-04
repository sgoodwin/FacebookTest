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
#import <Social/Social.h>
#import "RWSStevenViewController.h"

@interface RWSFriendListViewController()
@property (nonatomic, strong) RWSFriendList *friendList;
@property (nonatomic, strong) RWSImageManager *imageManager;
@end

static NSString *const CellIdentifier = @"Cell";

@implementation RWSFriendListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Friends";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(postSomething:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Steven" style:UIBarButtonItemStylePlain target:self action:@selector(showSteven:)];

    self.imageManager = [[RWSImageManager alloc] initWithDelegate:self];
    [self.tableView registerClass:[RWSFriendCell class] forCellReuseIdentifier:CellIdentifier];

    self.friendList = [[RWSFriendList alloc] init];
    [self.friendList addObserver:self forKeyPath:@"friends" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
    [self.friendList update];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if([self.friendList error]){
            NSString *errorMessage = [[self.friendList error] localizedDescription];
            NSString *message = [NSString stringWithFormat:@"Something went wrong loading your friend list. %@", errorMessage];
            [[[UIAlertView alloc] initWithTitle:@"Oops" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
        [self.tableView reloadData];
    });
}

- (void)postSomething:(id)sender
{
    SLComposeViewController *compose = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [compose setInitialText:@"Hello from the test app!"];
    compose.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:compose animated:YES completion:nil];
}

- (void)showSteven:(id)sender
{
    RWSStevenViewController *stevenController = [[RWSStevenViewController alloc] init];
    stevenController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:stevenController animated:YES completion:nil];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 61.0f;
}

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

    UIImage *image = [self.imageManager imageForIndexPath:indexPath];
    if(!image){
        [self.imageManager loadImageAtURLString:friend.imageURLString forIndexPath:indexPath];
    }
    cell.imageView.image = image;
    return cell;
}

#pragma mark - RWSImageManagerDelegate

- (void)imageManage:(RWSImageManager *)manager didLoadImageAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end
