//
//  FlickrImageCell.h
//  FlickrImageSearch
//
//  Created by Neetika on 27/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlickrImageCell : UICollectionViewCell

- (void)setImage:(nullable UIImage *)image;
+ (NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
