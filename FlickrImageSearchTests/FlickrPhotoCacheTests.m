//
//  FlickrPhotoCacheTests.m
//  FlickrImageSearchTests
//
//  Created by Neetika on 28/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FlickrPhotoCache.h"

@interface FlickrPhotoCacheTests : XCTestCase

@end

@implementation FlickrPhotoCacheTests

- (void)testSaveImage {
    NSString *imageName = @"placeholderSample";
    
    UIImage *image = [UIImage imageNamed:@"placeholderSample"];
    [FlickrPhotoCache saveImage:image name:@"placeholderSample"];
    
    UIImage *savedImage = [FlickrPhotoCache getImageWithName:imageName];
    XCTAssertEqualObjects(savedImage, image);
}

- (void)testGetImageWhenNoImageIsSaved {
    UIImage *savedImage = [FlickrPhotoCache getImageWithName:@"test"];
    XCTAssertNil(savedImage);
}

@end
