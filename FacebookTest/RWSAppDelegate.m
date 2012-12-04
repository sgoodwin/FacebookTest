//
//  RWSAppDelegate.m
//  FacebookTest
//
//  Created by Samuel Goodwin on 12/4/12.
//  Copyright (c) 2012 Roundwall Software. All rights reserved.
//

#import "RWSAppDelegate.h"
#import "RWSFriendListViewController.h"

@implementation RWSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    RWSFriendListViewController *controller = [[RWSFriendListViewController alloc] initWithStyle:UITableViewStylePlain];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    self.window.rootViewController = navigationController;
    return YES;
}

@end
