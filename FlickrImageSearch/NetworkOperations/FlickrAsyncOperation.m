//
//  FlickrAsyncOperation.m
//  FlickrImageSearch
//
//  Created by Neetika on 27/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import "FlickrAsyncOperation.h"

@implementation FlickrAsyncOperation

- (void)setReadyState:(BOOL)readyState
{
    if (_readyState != readyState)
    {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isReady))];
        _readyState = readyState;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isReady))];
    }
}

- (void)setIsExecuting:(BOOL)isExecuting
{
    if (_isExecuting != isExecuting)
    {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
        _isExecuting = isExecuting;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
    }
}

- (void)setIsFinished:(BOOL)isFinished
{
    if (_isFinished != isFinished)
    {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
        _isFinished = isFinished;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
    }
}

- (BOOL)isAsynchronous
{
    return YES;
}

- (void)start
{
    [super start];
    self.isExecuting = YES;
    self.isFinished = NO;
}

- (void)finisedExecuting {
    self.isExecuting = NO;
    self.isFinished = YES;
}

@end
