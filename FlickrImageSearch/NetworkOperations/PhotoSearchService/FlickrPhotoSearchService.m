//
//  FlickrPhotoSearchService.m
//  FlickrImageSearch
//
//  Created by Neetika on 27/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import "FlickrPhotoSearchService.h"
#import "FlickrPhotoSearchOperation.h"
#import "FlickrConstants.h"

@interface FlickrPhotoSearchService()

@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation FlickrPhotoSearchService

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static FlickrPhotoSearchService *flickrPhotoSearchService = nil;
    
    dispatch_once(&onceToken, ^{
        flickrPhotoSearchService = [[self alloc] init];
        flickrPhotoSearchService.operationQueue = [[NSOperationQueue alloc] init];
        flickrPhotoSearchService.operationQueue.name = @"com.flickrPhotoSearchService.operationQueue";
    });
    
    return flickrPhotoSearchService;
}

- (void)initialiseWithAPIKey:(NSString *)apiKey
{
    self.apiKey = apiKey;
}

- (void)asyncFetchFlickrPhotosForSearchText:(NSString *)searchText
                                       page:(NSInteger)page
                                 completion:(FlickrPhotoSearchServiceCompletionBlock)completion
{
    NSString *urlString = [NSString stringWithFormat:kFlickrPhotoSearchUrl, self.apiKey, searchText, @(page)];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    FlickrPhotoSearchOperation *operation = [[FlickrPhotoSearchOperation alloc] initWithUrl:[NSURL URLWithString:urlString]];
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(operation) weakOperation = operation;
    operation.completionBlock = ^{
        [weakSelf processResponse:weakOperation completion:completion];
    };
    [self.operationQueue addOperation:operation];
    
}

- (void)processResponse:(FlickrPhotoSearchOperation *)operation
             completion:(FlickrPhotoSearchServiceCompletionBlock)completion
{
    FlickrPhotosSearch *photosSearch = nil;
    NSError *error = nil;
    if (operation.error) {
        error = operation.error;
    }
    else {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:operation.responseData options:kNilOptions error:&error];
        if (!error) {
            photosSearch = [[FlickrPhotosSearch alloc] initWithDictionary:json];
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        completion(photosSearch, error);
    });
}

@end
