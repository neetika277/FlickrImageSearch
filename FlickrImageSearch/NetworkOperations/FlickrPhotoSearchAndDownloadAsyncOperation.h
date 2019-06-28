//
//  FlickrPhotoSearchAndDownloadAsyncOperation.h
//  FlickrImageSearch
//
//  Created by Neetika on 27/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import "FlickrAsyncOperation.h"

NS_ASSUME_NONNULL_BEGIN

@interface FlickrPhotoSearchAndDownloadAsyncOperation : FlickrAsyncOperation
// to be used by service
@property (nonatomic, strong) NSData *responseData;
@property (nonatomic, strong) NSURLResponse *urlResponse;
@property (nonatomic, strong) NSError *error;

- (instancetype)initWithUrl:(NSURL *)url;
@end

NS_ASSUME_NONNULL_END
