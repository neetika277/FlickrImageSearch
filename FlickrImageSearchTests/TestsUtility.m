//
//  TestsUtility.m
//  FlickrImageSearchTests
//
//  Created by Neetika on 28/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import "TestsUtility.h"

@implementation TestsUtility

+ (NSDictionary *)loadJsonFileWithName:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:name ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

@end
