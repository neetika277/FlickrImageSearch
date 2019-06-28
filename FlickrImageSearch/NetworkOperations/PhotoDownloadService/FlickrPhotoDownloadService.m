//
//  FlickrPhotoDownloadService.m
//  FlickrImageSearch
//
//  Created by Neetika on 27/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import "FlickrPhotoDownloadService.h"
#import "FlickrPhotoDownloadOperation.h"
#import "FlickrConstants.h"

@interface FlickrPhotoDownloadService()

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

//http://farm{farm}.static.flickr.com/{server}/{id}_{secret}.jpg
@implementation FlickrPhotoDownloadService

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static FlickrPhotoDownloadService *flickrPhotoDownloadService = nil;
    
    dispatch_once(&onceToken, ^{
        flickrPhotoDownloadService = [[self alloc] init];
        flickrPhotoDownloadService.operationQueue = [[NSOperationQueue alloc] init];
        flickrPhotoDownloadService.operationQueue.name = @"com.flickrPhotoDownloadService.operationQueue";
    });
    
    return flickrPhotoDownloadService;
}

- (void)asyncDownloadPhotoWithFarm:(NSInteger)farm
                            server:(NSString *)server
                           photoId:(NSString *)photoId
                            secret:(NSString *)secret
                        completion:(FlickrPhotoDownloadServiceCompletionBlock)completion
{
    NSString *urlString = [NSString stringWithFormat:kFlickrPhotoDownloadUrl, @(farm), server, photoId, secret];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    FlickrPhotoDownloadOperation *operation = [[FlickrPhotoDownloadOperation alloc] initWithUrl:[NSURL URLWithString:urlString]];
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(operation) weakOperation = operation;
    operation.completionBlock = ^{
        [weakSelf processResponse:weakOperation completion:completion];
    };
    [self.operationQueue addOperation:operation];
}

- (void)processResponse:(FlickrPhotoDownloadOperation *)operation
             completion:(FlickrPhotoDownloadServiceCompletionBlock)completion
{
    UIImage *image = nil;
    NSError *error = nil;
    if (operation.error) {
        error = operation.error;
    }
    else {
        image = [UIImage imageWithData:operation.responseData];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        completion(image, error);
    });
}

- (void)cancelPendingPhotoDownloads {
    [self.operationQueue cancelAllOperations];
}

@end
