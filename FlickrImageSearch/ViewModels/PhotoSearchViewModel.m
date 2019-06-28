//
//  PhotoSearchViewModel.m
//  FlickrImageSearch
//
//  Created by Neetika on 27/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoSearchViewModel.h"
#import "FlickrPhotoSearchService.h"
#import "FlickrPhotoDownloadService.h"
#import "FlickrPhotosSearch.h"
#import "FlickrPhotoCache.h"
#import "FlickrPhoto.h"

@interface PhotoSearchViewModel()

@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) FlickrPhotosSearch *flickrPhotosSearch;
@property (nonatomic, strong) NSMutableSet <NSString *> *requestedPhotos;

@end

@implementation PhotoSearchViewModel

- (instancetype)initWithDelegate:(id <PhotoSearchViewModelDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.requestedPhotos = [NSMutableSet set];
    }
    return self;
}

- (void)setSearchText:(NSString *)searchText {
    if (![_searchText isEqualToString:searchText]) {
        _searchText = searchText;
        [[FlickrPhotoDownloadService sharedInstance] cancelPendingPhotoDownloads];
        self.flickrPhotosSearch = nil;
        [self.requestedPhotos removeAllObjects];
        self.currentPage = 1;
        [self asyncFetchPhotos];
    }
}

- (void)asyncFetchPhotos {
    self.isLoading = YES;
    __weak typeof(self) weakSelf = self;
    [[FlickrPhotoSearchService sharedInstance] asyncFetchFlickrPhotosForSearchText:self.searchText
                                                                              page:self.currentPage completion:^(FlickrPhotosSearch * response, NSError *error) {
                                                                                  weakSelf.isLoading = NO;
                                                                                  if (!error) {
                                                                                      [weakSelf processFlickrResponse:response];
                                                                                  }
                                                                                  if ([weakSelf.delegate respondsToSelector:@selector(didCompleteFlickrPhotoSearch:error:)]) {
                                                                                      [weakSelf.delegate didCompleteFlickrPhotoSearch:!error error:error];
                                                                                  }
                                                                              }];
}

- (void)processFlickrResponse:(FlickrPhotosSearch *) response {
    NSArray *oldPhotos = self.flickrPhotosSearch.photos;
    self.flickrPhotosSearch = response;
    [self.flickrPhotosSearch updatePhotosWithPreviousPhotos:oldPhotos];
}

- (void)loadNextPage {
    if (!self.isLoading) {
        self.currentPage++;
        [self asyncFetchPhotos];
    }
}

- (NSInteger)numberOfItemsInCollectionView {
    return self.flickrPhotosSearch.photos.count;
}

- (UIImage *)imageForCellAtIndexPath:(NSIndexPath *)indexPath {
    FlickrPhoto *photo = self.flickrPhotosSearch.photos[indexPath.item];
    UIImage *image = nil;
    if (![self.requestedPhotos containsObject:photo.photoId]) {
        image = [FlickrPhotoCache getImageWithName:photo.photoId];
        if (!image) {
            [self asyncFetchFlickrPhoto:photo atIndexPath:indexPath];
        }
    }
    return image;
}

- (void)asyncFetchFlickrPhoto:(FlickrPhoto *)flickrPhoto atIndexPath:(NSIndexPath *)indexPath {
    if (!flickrPhoto) {
        return;
    }
    [self.requestedPhotos addObject:flickrPhoto.photoId];
    __weak typeof(self) weakSelf = self;
    [[FlickrPhotoDownloadService sharedInstance] asyncDownloadPhotoWithFarm:flickrPhoto.farm server:flickrPhoto.server photoId:flickrPhoto.photoId secret:flickrPhoto.secret completion:^(UIImage *image, NSError *error) {
        [weakSelf.requestedPhotos removeObject:flickrPhoto.photoId];
        if (image) {
            [weakSelf asyncSaveDownloadedPhoto:image name:flickrPhoto.photoId];
        }
        if ([weakSelf.delegate respondsToSelector:@selector(didCompleteFlickrPhotoDownloadForIndexPath:image:error:)]) {
            [weakSelf.delegate didCompleteFlickrPhotoDownloadForIndexPath:indexPath image:image error:error];
        }
    }];
}

- (void)asyncSaveDownloadedPhoto:(UIImage *)image name:(NSString *)photoId {
    dispatch_async(dispatch_get_main_queue(), ^{
        [FlickrPhotoCache saveImage:image name:photoId];
    });
}

- (BOOL)showNoDataView {
    return !self.numberOfItemsInCollectionView;
}

@end
