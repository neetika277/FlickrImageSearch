//
//  FlickrPhotosSearch.h
//  FlickrImageSearch
//
//  Created by Neetika on 27/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FlickrPhoto;

@interface FlickrPhotosSearch : NSObject

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger totalPages;
@property (nonatomic, assign) NSInteger perPage;
@property (nonatomic, assign) NSInteger totalPhotos;
@property (nonatomic, strong) NSArray <FlickrPhoto *> *photos;
@property (nonatomic, strong) NSString *stat;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary NS_DESIGNATED_INITIALIZER;
- (void)updatePhotosWithPreviousPhotos:(NSArray <FlickrPhoto *> *)oldPhotos;

@end

NS_ASSUME_NONNULL_END
