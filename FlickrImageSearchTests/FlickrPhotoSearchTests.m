//
//  FlickrPhotoSearchTests.m
//  FlickrImageSearchTests
//
//  Created by Neetika on 28/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FlickrPhotosSearch.h"
#import "TestsUtility.h"

@interface FlickrPhotoSearchTests : XCTestCase

@end

@implementation FlickrPhotoSearchTests

- (void)testInitWithDictionary {
    NSDictionary *json = [TestsUtility loadJsonFileWithName:@"FlickrPhotoSearchSample"];
    FlickrPhotosSearch *photoSearch = [[FlickrPhotosSearch alloc] initWithDictionary:json];
    XCTAssertEqualObjects(photoSearch.stat, @"ok");
    XCTAssertEqual(photoSearch.page, 1);
    XCTAssertEqual(photoSearch.totalPages, 1657);
    XCTAssertEqual(photoSearch.perPage, 100);
    XCTAssertEqual(photoSearch.totalPhotos, 165673);
    XCTAssertEqual(photoSearch.photos.count, 100);
}

- (void)testUpdatePhotosWithPreviousPhotos {
    NSDictionary *json = [TestsUtility loadJsonFileWithName:@"FlickrPhotoSearchSample"];
    FlickrPhotosSearch *photoSearch = [[FlickrPhotosSearch alloc] initWithDictionary:json];
    XCTAssertEqualObjects(photoSearch.stat, @"ok");
    XCTAssertEqual(photoSearch.page, 1);
    XCTAssertEqual(photoSearch.totalPages, 1657);
    XCTAssertEqual(photoSearch.perPage, 100);
    XCTAssertEqual(photoSearch.totalPhotos, 165673);
    XCTAssertEqual(photoSearch.photos.count, 100);

    json = [TestsUtility loadJsonFileWithName:@"FlickrPhotoSearchPage2Sample"];
    FlickrPhotosSearch *photoSearchPage2 = [[FlickrPhotosSearch alloc] initWithDictionary:json];
    XCTAssertEqualObjects(photoSearchPage2.stat, @"ok");
    XCTAssertEqual(photoSearchPage2.page, 2);
    XCTAssertEqual(photoSearchPage2.totalPages, 1642);
    XCTAssertEqual(photoSearchPage2.perPage, 100);
    XCTAssertEqual(photoSearchPage2.totalPhotos, 164184);
    XCTAssertEqual(photoSearchPage2.photos.count, 100);

    [photoSearchPage2 updatePhotosWithPreviousPhotos:photoSearch.photos];
    XCTAssertEqual(photoSearchPage2.photos.count, 200);
}

@end
