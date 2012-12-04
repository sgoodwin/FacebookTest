//
//  RWSFriend.h
//  FacebookTest
//
//  Created by Samuel Goodwin on 12/4/12.
//  Copyright (c) 2012 Roundwall Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWSFriend : NSObject
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *imageURLString;

+ (NSArray *)friendsFromJSONArray:(NSArray *)jsonArray;
@end
