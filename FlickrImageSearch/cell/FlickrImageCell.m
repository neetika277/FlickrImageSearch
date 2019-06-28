//
//  FlickrImageCell.m
//  FlickrImageSearch
//
//  Created by Neetika on 27/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import "FlickrImageCell.h"

@interface FlickrImageCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation FlickrImageCell

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([FlickrImageCell class]);
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.imageView.image = [UIImage imageNamed:@"Image"];
    self.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.7].CGColor;
    self.layer.borderWidth = 1/[UIScreen mainScreen].scale;
}

- (void)setImage:(nullable UIImage *)image {
    self.imageView.image = image ? image : [UIImage imageNamed:@"Image"];
}

@end
