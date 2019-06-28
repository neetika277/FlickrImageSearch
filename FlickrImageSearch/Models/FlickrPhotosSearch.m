//
//  FlickrPhotosSearch.m
//  FlickrImageSearch
//
//  Created by Neetika on 27/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import "FlickrPhotosSearch.h"
#import "FlickrPhoto.h"

@implementation FlickrPhotosSearch

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        NSDictionary *photosDictionary = dictionary[@"photos"];
        self.page = [photosDictionary[@"page"] integerValue];
        self.totalPages = [photosDictionary[@"pages"] integerValue];
        self.perPage = [photosDictionary[@"perpage"] integerValue];
        self.totalPhotos = [photosDictionary[@"total"] integerValue];
        NSArray *photos = photosDictionary[@"photo"];
        NSMutableArray <FlickrPhoto *> *mutablePhotos = [[NSMutableArray alloc] initWithCapacity:photos.count];
        for (NSDictionary *photo in photos) {
            FlickrPhoto *flickrPhoto = [[FlickrPhoto alloc] initWithDictionary:photo];
            [mutablePhotos addObject:flickrPhoto];
        }
        self.photos = [NSArray arrayWithArray:mutablePhotos];
        self.stat = dictionary[@"stat"];
    }
    return self;
}

- (void)updatePhotosWithPreviousPhotos:(NSArray <FlickrPhoto *> *)oldPhotos {
    if (oldPhotos.count) {
        NSMutableArray <FlickrPhoto *> *mutablePhotos = oldPhotos.mutableCopy;
        [mutablePhotos addObjectsFromArray:self.photos];
        self.photos = mutablePhotos.copy;
    }
}

@end
