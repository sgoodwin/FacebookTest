//
//  RWSStevenViewController.m
//  FacebookTest
//
//  Created by Samuel Goodwin on 12/4/12.
//  Copyright (c) 2012 Roundwall Software. All rights reserved.
//

#import "RWSStevenViewController.h"

@implementation RWSStevenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.facebook.com/steven.lammertink"]]];
}

@end
