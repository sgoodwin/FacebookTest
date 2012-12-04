//
//  RWSFriendList.m
//  FacebookTest
//
//  Created by Samuel Goodwin on 12/4/12.
//  Copyright (c) 2012 Roundwall Software. All rights reserved.
//

#import "RWSFriendList.h"
#import "RWSFriend.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@implementation RWSFriendList

- (void)requestPermissionTo:(ACAccountStoreRequestAccessCompletionHandler)block
{
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    NSArray *permissions = @[@"email", @"user_location", @"user_about_me", @"friends_location"];
    NSDictionary *options = @{ACFacebookAppIdKey : @"468767743162251", ACFacebookPermissionsKey : permissions, ACFacebookAudienceKey : ACFacebookAudienceOnlyMe};
    [accountStore requestAccessToAccountsWithType:accountType options:options completion:block];
}

- (void)getFriendListWithPermission
{
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    NSArray *accounts = [accountStore accountsWithAccountType:accountType];
    // For the sake of this demo, we'll just assume you only have one account.
    ACAccount *account = accounts[0];

    NSURL *url = [NSURL URLWithString:@"https://graph.facebook.com/me/friends"];
    SLRequest *friendRequest = [SLRequest requestForServiceType:SLServiceTypeFacebook requestMethod:SLRequestMethodGET URL:url parameters:@{@"fields": @"name,location"}];
    [friendRequest setAccount:account];
    [friendRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        if(responseData){
            [self handleFriendData:responseData];
        }else{
            self.error = error;
            self.friends = @[];
        }
    }];
}

- (void)handleFriendData:(NSData *)data
{
    NSError *jsonError = nil;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    if(!jsonDictionary){
        self.error = jsonError;
        self.friends = @[];
        return;
    }

    self.friends = [RWSFriend friendsFromJSONArray:jsonDictionary[@"data"]];
}

#pragma mark - API

- (RWSFriend *)friendAtIndex:(NSUInteger)index
{
    return self.friends[index];
}

- (NSUInteger)friendCount
{
    return [self.friends count];
}

- (void)update
{
    [self requestPermissionTo:^(BOOL granted, NSError *error) {
        if(granted){
            [self getFriendListWithPermission];
        }else{
            self.error = error;
            self.friends = @[];
        }
    }];
}

@end
