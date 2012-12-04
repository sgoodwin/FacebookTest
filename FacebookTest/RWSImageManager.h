//
//  RWSImageManager.h
//  FacebookTest
//
//  Created by Samuel Goodwin on 12/4/12.
//  Copyright (c) 2012 Roundwall Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RWSImageManagerDelegate;
@interface RWSImageManager : NSObject
@property (nonatomic, weak) id<RWSImageManagerDelegate> delegate;

- (id)initWithDelegate:(id<RWSImageManagerDelegate>)delegate;

- (UIImage *)imageForIndexPath:(NSIndexPath *)indexPath;
- (void)loadImageAtURLString:(NSString *)urlString forIndexPath:(NSIndexPath *)indexPath;
@end

@protocol RWSImageManagerDelegate
@required;
- (void)imageManage:(RWSImageManager *)manager didLoadImageAtIndexPath:(NSIndexPath *)indexPath;
@end