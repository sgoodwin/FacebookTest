//
//  RWSFriend.m
//  FacebookTest
//
//  Created by Samuel Goodwin on 12/4/12.
//  Copyright (c) 2012 Roundwall Software. All rights reserved.
//

#import "RWSFriend.h"

@implementation RWSFriend

+ (NSArray *)friendsFromJSONArray:(NSArray *)jsonArray
{
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:[jsonArray count]];
    [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        RWSFriend *friend = [[self alloc] init];
        NSString *name = obj[@"name"];
        NSArray *names = [name componentsSeparatedByString:@" "];
        friend.firstName = names[0];
        if([names count] > 1){
            friend.lastName = names[1];
        }

        NSString *userID = obj[@"id"];
        friend.imageURLString = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=60&height=60", userID];
        [results addObject:friend];
    }];

    return results;
}

@end
