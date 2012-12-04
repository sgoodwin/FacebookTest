//
//  RWSImageManager.m
//  FacebookTest
//
//  Created by Samuel Goodwin on 12/4/12.
//  Copyright (c) 2012 Roundwall Software. All rights reserved.
//

#import "RWSImageManager.h"

@interface RWSImageManager()
@property (nonatomic, strong) NSCache *images;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@end

@implementation RWSImageManager

- (id)initWithDelegate:(id<RWSImageManagerDelegate>)delegate;
{
    self = [super init];
    if(self){
        self.images = [[NSCache alloc] init];
        self.images.name = @"com.roundwall.imageCache";
        self.delegate = delegate;
        self.operationQueue = [[NSOperationQueue alloc] init];
        self.operationQueue.name = @"com.roundwall.imageQueue";
    }
    return self;
}

- (UIImage *)imageForIndexPath:(NSIndexPath *)indexPath
{
    return [self.images objectForKey:indexPath];
}

- (void)loadImageAtURLString:(NSString *)urlString forIndexPath:(NSIndexPath *)indexPath
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [NSURLConnection sendAsynchronousRequest:request queue:self.operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        UIImage *image = [UIImage imageWithData:data];
        if(image){
            [self.images setObject:image forKey:indexPath];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate imageManage:self didLoadImageAtIndexPath:indexPath];
            });
        }
    }];
}

@end
