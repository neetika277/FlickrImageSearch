//
//  FlickrPhotoDownloadService.h
//  FlickrImageSearch
//
//  Created by Neetika on 27/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^FlickrPhotoDownloadServiceCompletionBlock) (UIImage * _Nullable image, NSError * _Nullable error);

@interface FlickrPhotoDownloadService : NSObject

+ (instancetype)sharedInstance;
- (void)asyncDownloadPhotoWithFarm:(NSInteger)farm
                            server:(NSString *)server
                           photoId:(NSString *)photoId
                            secret:(NSString *)secret
                        completion:(FlickrPhotoDownloadServiceCompletionBlock)completion;
- (void)cancelPendingPhotoDownloads;

@end

NS_ASSUME_NONNULL_END
