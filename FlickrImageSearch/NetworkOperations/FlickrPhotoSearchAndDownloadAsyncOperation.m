//
//  FlickrPhotoSearchAndDownloadAsyncOperation.m
//  FlickrImageSearch
//
//  Created by Neetika on 27/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import "FlickrPhotoSearchAndDownloadAsyncOperation.h"

@interface FlickrPhotoSearchAndDownloadAsyncOperation()

@property (nonatomic, strong) NSURL *url;

@end

@implementation FlickrPhotoSearchAndDownloadAsyncOperation

- (instancetype)initWithUrl:(NSURL *)url
{
    self = [super init];
    if (self) {
        self.url = url;
        self.readyState = YES;
    }
    return self;
}

-(void)start
{
    [super start];
    [self asyncFetchFlickrPhotos];
}

- (void)asyncFetchFlickrPhotos {
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask * dataTask = [[NSURLSession sharedSession] dataTaskWithURL:self.url
                                                                  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
                                                                      weakSelf.responseData = data;
                                                                      weakSelf.error = error;
                                                                      weakSelf.urlResponse = response;
                                                                      [weakSelf finisedExecuting];
                                                                  }];
    
    [dataTask resume];
}

@end
