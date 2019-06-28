//
//  FlickrPhotoCache.h
//  FlickrImageSearch
//
//  Created by Neetika on 27/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlickrPhotoCache : NSObject

+ (void)saveImage:(UIImage *)image name:(NSString *)name;
+ (nullable UIImage *)getImageWithName:(NSString *)name ;

@end

NS_ASSUME_NONNULL_END
