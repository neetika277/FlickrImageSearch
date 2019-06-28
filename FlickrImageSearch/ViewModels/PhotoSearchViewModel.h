//
//  PhotoSearchViewModel.h
//  FlickrImageSearch
//
//  Created by Neetika on 27/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PhotoSearchViewModelDelegate <NSObject>

- (void)didCompleteFlickrPhotoSearch:(BOOL)success error:(nullable NSError *)error;
- (void)didCompleteFlickrPhotoDownloadForIndexPath:(NSIndexPath *)ip image:(nullable UIImage *)image error:(nullable NSError *)error;

@end

@interface PhotoSearchViewModel : NSObject

@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, weak) id <PhotoSearchViewModelDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDelegate:(id <PhotoSearchViewModelDelegate>)delegate NS_DESIGNATED_INITIALIZER;
- (void)loadNextPage;
- (NSInteger)numberOfItemsInCollectionView;
- (UIImage *)imageForCellAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)showNoDataView;

@end

NS_ASSUME_NONNULL_END
