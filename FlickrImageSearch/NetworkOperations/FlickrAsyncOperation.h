//
//  FlickrAsyncOperation.h
//  FlickrImageSearch
//
//  Created by Neetika on 27/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlickrAsyncOperation : NSOperation

@property(readonly) BOOL isExecuting;
@property(readonly) BOOL isFinished;
@property (nonatomic, assign) BOOL readyState;

- (void)finisedExecuting;

@end

NS_ASSUME_NONNULL_END
