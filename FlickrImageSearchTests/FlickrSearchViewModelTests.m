//
//  FlickrSearchViewModelTests.m
//  FlickrImageSearchTests
//
//  Created by Neetika on 28/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PhotoSearchViewModel.h"
#import "FlickrPhotosSearch.h"
#import "TestsUtility.h"
#import "FlickrPhotoCache.h"
#import "FlickrPhoto.h"

@interface PhotoSearchViewModel(UnitTest)

@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) FlickrPhotosSearch *flickrPhotosSearch;
@property (nonatomic, strong) NSMutableSet <NSString *> *requestedPhotos;
@property (nonatomic, assign) NSInteger currentPage;
- (void)asyncFetchPhotos;
- (void)asyncFetchFlickrPhoto:(FlickrPhoto *)flickrPhoto atIndexPath:(NSIndexPath *)indexPath;

@end

typedef void (^CompletionBlock) (void);

@interface FlickrSearchViewModelTests : XCTestCase <PhotoSearchViewModelDelegate>

@property (nonatomic, strong) CompletionBlock completionBlock;

@end

@implementation FlickrSearchViewModelTests

- (void)testInitWithDelegate {
    PhotoSearchViewModel *photoSearchViewModel = [[PhotoSearchViewModel alloc] initWithDelegate:self];
    XCTAssertEqualObjects(photoSearchViewModel.delegate, self);
    XCTAssertNotNil(photoSearchViewModel.requestedPhotos);
}

- (void)testSetSearchText {
    PhotoSearchViewModel *photoSearchViewModel = [[PhotoSearchViewModel alloc] initWithDelegate:self];
    photoSearchViewModel.searchText = @"Kittens";
    
    XCTAssertEqualObjects(photoSearchViewModel.searchText, @"Kittens");
    XCTAssertNil(photoSearchViewModel.flickrPhotosSearch);
    XCTAssertEqual(photoSearchViewModel.requestedPhotos.count, 0);
    XCTAssertEqual(photoSearchViewModel.currentPage, 1);
}

- (void)testAsyncFetchPhotos {
    PhotoSearchViewModel *photoSearchViewModel = [[PhotoSearchViewModel alloc] initWithDelegate:self];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"FetchPhotosExpectation"];
    __weak typeof(self)weakSelf = self;
    self.completionBlock = ^{
        id self = weakSelf;
        XCTAssertEqual(photoSearchViewModel.isLoading, NO);
        [expectation fulfill];
    };
    
    [photoSearchViewModel asyncFetchPhotos];
    XCTAssertEqual(photoSearchViewModel.isLoading, YES);
    
    [self waitForExpectationsWithTimeout:20.0 handler:nil];
}

- (void)testNumberOfItemsInCollectionView {
    PhotoSearchViewModel *photoSearchViewModel = [[PhotoSearchViewModel alloc] initWithDelegate:self];
    NSDictionary *json = [TestsUtility loadJsonFileWithName:@"FlickrPhotoSearchSample"];
    photoSearchViewModel.flickrPhotosSearch = [[FlickrPhotosSearch alloc] initWithDictionary:json];
    
    XCTAssertEqual([photoSearchViewModel numberOfItemsInCollectionView], 100);
}

- (void)testImageForCellAtIndexPath_WhenImageAlreadyCached {
    UIImage *image = [UIImage imageNamed:@"placeholderSample"];
    [FlickrPhotoCache saveImage:image name:@"placeholderSample"];

    PhotoSearchViewModel *photoSearchViewModel = [[PhotoSearchViewModel alloc] initWithDelegate:self];
    NSDictionary *json = [TestsUtility loadJsonFileWithName:@"FlickrPhotoSearchSample"];
    photoSearchViewModel.flickrPhotosSearch = [[FlickrPhotosSearch alloc] initWithDictionary:json];
    FlickrPhoto *photo = photoSearchViewModel.flickrPhotosSearch.photos.firstObject;
    photo.photoId = @"placeholderSample";
    
    UIImage *imageAtIndexpath = [photoSearchViewModel imageForCellAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    XCTAssertEqualObjects(imageAtIndexpath, image);
}

- (void)testImageForCellAtIndexPath_WhenImageIsDownloading {
    PhotoSearchViewModel *photoSearchViewModel = [[PhotoSearchViewModel alloc] initWithDelegate:self];
    NSDictionary *json = [TestsUtility loadJsonFileWithName:@"FlickrPhotoSearchSample"];
    photoSearchViewModel.flickrPhotosSearch = [[FlickrPhotosSearch alloc] initWithDictionary:json];
    FlickrPhoto *photo = photoSearchViewModel.flickrPhotosSearch.photos.firstObject;
    photo.photoId = @"placeholderSample";
    [photoSearchViewModel.requestedPhotos addObject:@"placeholderSample"];
    
    UIImage *imageAtIndexpath = [photoSearchViewModel imageForCellAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    XCTAssertNil(imageAtIndexpath);
}

- (void)testShowNoDataView_WhenResultsAvailable {
    PhotoSearchViewModel *photoSearchViewModel = [[PhotoSearchViewModel alloc] initWithDelegate:self];
    NSDictionary *json = [TestsUtility loadJsonFileWithName:@"FlickrPhotoSearchSample"];
    photoSearchViewModel.flickrPhotosSearch = [[FlickrPhotosSearch alloc] initWithDictionary:json];
    
    BOOL showNoDataView = [photoSearchViewModel showNoDataView];
    XCTAssertFalse(showNoDataView);
}

- (void)testShowNoDataView_WhenNoResultsAvailable {
    PhotoSearchViewModel *photoSearchViewModel = [[PhotoSearchViewModel alloc] initWithDelegate:self];
    BOOL showNoDataView = [photoSearchViewModel showNoDataView];
    XCTAssertTrue(showNoDataView);
}

- (void)testAsyncFetchFlickrPhoto {
    NSDictionary *json = [TestsUtility loadJsonFileWithName:@"FlickrPhotoSample"];
    FlickrPhoto *photo = [[FlickrPhoto alloc] initWithDictionary:json];
    PhotoSearchViewModel *photoSearchViewModel = [[PhotoSearchViewModel alloc] initWithDelegate:self];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"DownloadPhotosExpectation"];
    __weak typeof(self)weakSelf = self;
    self.completionBlock = ^{
        id self = weakSelf;
        XCTAssertEqual(photoSearchViewModel.requestedPhotos.count, 0);
        [expectation fulfill];
    };
    
    [photoSearchViewModel asyncFetchFlickrPhoto:photo atIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    XCTAssertEqual(photoSearchViewModel.requestedPhotos.count, 1);

    [self waitForExpectationsWithTimeout:20.0 handler:nil];

}

#pragma mark - PhotoSearchViewModelDelegate

- (void)didCompleteFlickrPhotoSearch:(BOOL)success error:(nullable NSError *)error {
    if (self.completionBlock) {
        self.completionBlock();
    }
}

- (void)didCompleteFlickrPhotoDownloadForIndexPath:(NSIndexPath *)ip image:(nullable UIImage *)image error:(nullable NSError *)error {
    if (self.completionBlock) {
        self.completionBlock();
    }
}


@end
