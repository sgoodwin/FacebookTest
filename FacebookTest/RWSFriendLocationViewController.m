//
//  RWSFriendLocationViewController.m
//  FacebookTest
//
//  Created by Samuel Goodwin on 12/4/12.
//  Copyright (c) 2012 Roundwall Software. All rights reserved.
//

#import "RWSFriendLocationViewController.h"
#import "RWSFriend.h"
#import <CoreLocation/CoreLocation.h>
#import "RWSLocation.h"

@interface RWSFriendLocationViewController()
@property (nonatomic, strong) NSString *locationString;
@end

@implementation RWSFriendLocationViewController

- (id)initWithFriend:(RWSFriend *)friend
{
    self = [super init];
    if (self) {
        self.locationString = friend.location;
        self.title = friend.firstName;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.mapView setShowsUserLocation:YES];

    CLGeocoder *coder = [[CLGeocoder alloc] init];
    [coder geocodeAddressString:self.locationString completionHandler:^(NSArray *placemarks, NSError *error) {
        if(![placemarks count]){
            return;
        }
        CLPlacemark *placemark = placemarks[0];
        
        RWSLocation *location = [[RWSLocation alloc] init];
        location.title = self.title;
        location.coordinate = placemark.location.coordinate;

        [self.mapView addAnnotation:location];
        [self.mapView setCenterCoordinate:location.coordinate];
        [self.mapView selectAnnotation:location animated:YES];
    }];
}

@end
