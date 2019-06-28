//
//  FlickrPhotoCache.m
//  FlickrImageSearch
//
//  Created by Neetika on 27/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import "FlickrPhotoCache.h"

@implementation FlickrPhotoCache

+ (NSString *)getCacheDirectoryPath {
    NSArray *cacheDirectories = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [cacheDirectories objectAtIndex:0];
}

+ (void)saveImage:(UIImage *)image name:(NSString *)name {
    if (image) {
        NSData *imageData = UIImagePNGRepresentation(image);
        NSString *imagePath =[NSString stringWithFormat:@"%@/%@.png", [FlickrPhotoCache getCacheDirectoryPath], name];
        [imageData writeToFile:imagePath atomically:YES];
    }
}

+ (UIImage *)getImageWithName:(NSString *)name {
    NSString *imagePath =[NSString stringWithFormat:@"%@/%@.png", [FlickrPhotoCache getCacheDirectoryPath], name];
    UIImage *image =[UIImage imageWithContentsOfFile:imagePath];
    return image;
}

@end
