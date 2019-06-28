//
//  FlickrPhotoSearchService.h
//  FlickrImageSearch
//
//  Created by Neetika on 27/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlickrPhotosSearch.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^FlickrPhotoSearchServiceCompletionBlock) (FlickrPhotosSearch * _Nullable response, NSError * _Nullable error);

@interface FlickrPhotoSearchService : NSObject

+ (instancetype)sharedInstance;
- (void)initialiseWithAPIKey:(NSString *)apiKey;
- (void)asyncFetchFlickrPhotosForSearchText:(NSString *)searchText
                                       page:(NSInteger)page
                                 completion:(FlickrPhotoSearchServiceCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
