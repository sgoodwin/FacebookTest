//
//  RWSFriendList.m
//  FacebookTest
//
//  Created by Samuel Goodwin on 12/4/12.
//  Copyright (c) 2012 Roundwall Software. All rights reserved.
//

#import "RWSFriendList.h"
#import "RWSFriend.h"

@implementation RWSFriendList

- (void)update
{
    RWSFriend *friend = [[RWSFriend alloc] init];
    friend.firstName = @"Paul";
    friend.lastName = @"Newman";
    self.friends = @[friend];
}

- (RWSFriend *)friendAtIndex:(NSUInteger)index
{
    return self.friends[index];
}

- (NSUInteger)friendCount
{
    return [self.friends count];
}

@end
