//
//  RWSFriendLocationViewController.h
//  FacebookTest
//
//  Created by Samuel Goodwin on 12/4/12.
//  Copyright (c) 2012 Roundwall Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class RWSFriend;
@interface RWSFriendLocationViewController : UIViewController
@property (nonatomic, weak) IBOutlet MKMapView *mapView;

- (id)initWithFriend:(RWSFriend *)friend;

@end
