//
//  RWSFriendList.h
//  FacebookTest
//
//  Created by Samuel Goodwin on 12/4/12.
//  Copyright (c) 2012 Roundwall Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RWSFriend;

@interface RWSFriendList : NSObject
@property (nonatomic, strong) NSArray *friends;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, readonly) NSUInteger friendCount;

- (RWSFriend *)friendAtIndex:(NSUInteger)index;
- (void)update;
@end
