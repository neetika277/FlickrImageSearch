//
//  FlickrPhotoTests.m
//  FlickrImageSearchTests
//
//  Created by Neetika on 28/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestsUtility.h"
#import "FlickrPhoto.h"

@interface FlickrPhotoTests : XCTestCase

@end

@implementation FlickrPhotoTests

- (void)testInitWithDictionary {
    NSDictionary *json = [TestsUtility loadJsonFileWithName:@"FlickrPhotoSample"];
    FlickrPhoto *photo = [[FlickrPhoto alloc] initWithDictionary:json];
    XCTAssertEqualObjects(photo.photoId, @"48131530483");
    XCTAssertEqualObjects(photo.owner, @"24209378@N03");
    XCTAssertEqualObjects(photo.secret, @"9afe92819b");
    XCTAssertEqualObjects(photo.server, @"65535");
    XCTAssertEqualObjects(photo.title, @"Wilma's first kittens");
    XCTAssertEqual(photo.isFriend, 0);
    XCTAssertEqual(photo.isFamily, 0);
    XCTAssertEqual(photo.farm, 66);
    XCTAssertEqual(photo.isPublic, 1);
}

@end

