//
//  ViewController.m
//  FlickrImageSearch
//
//  Created by Neetika on 27/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import "ViewController.h"
#import "PhotoSearchViewModel.h"
#import "FlickrImageCell.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PhotoSearchViewModelDelegate, UISearchBarDelegate>

@property (nonatomic, strong) PhotoSearchViewModel *photoSearchViewModel;
@property (weak, nonatomic) IBOutlet UIView *noDataView;
@property (weak, nonatomic) IBOutlet UILabel *noDataLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoSearchViewModel = [[PhotoSearchViewModel alloc] initWithDelegate:self];
    [self setUpSearchController];
    [self updateNoDataViewVisibility];
}

- (void)setUpSearchController {
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchBar.delegate = self;
    searchController.obscuresBackgroundDuringPresentation = YES;
    searchController.searchBar.placeholder = @"Search Flickr";
    self.navigationItem.searchController = searchController;
    self.definesPresentationContext = YES;
}

- (void)updateNoDataViewVisibility {
    BOOL showNoDataView = [self.photoSearchViewModel showNoDataView];
    self.collectionView.hidden = showNoDataView;
    self.noDataView.hidden = !showNoDataView;
    self.noDataLabel.text = @"No data available";
}

#pragma mark - collectionview datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.photoSearchViewModel numberOfItemsInCollectionView];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FlickrImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[FlickrImageCell reuseIdentifier] forIndexPath:indexPath];
    [cell setImage:[self.photoSearchViewModel imageForCellAtIndexPath:indexPath]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == self.photoSearchViewModel.numberOfItemsInCollectionView - 3) {
        [self.photoSearchViewModel loadNextPage];
    }
}

#pragma mark - flowlayout delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat margin = 15.0;
    CGFloat paddingBetweenItems = margin/2.0;
    // we need to show 3 items in a row
    CGFloat dimensionForItem = (collectionView.frame.size.width - 2 * margin - 2 * paddingBetweenItems)/3.0;
    return CGSizeMake(dimensionForItem, dimensionForItem);
}

#pragma mark - PhotoSearchViewModelDelegate

- (void)didCompleteFlickrPhotoSearch:(BOOL)success error:(nullable NSError *)error {
    // hide loader
    [self updateNoDataViewVisibility];
    if (error) {
        self.noDataLabel.text = error.localizedDescription;
    }
    else {
        [self.collectionView reloadData];
    }
}

- (void)didCompleteFlickrPhotoDownloadForIndexPath:(NSIndexPath *)ip image:(nullable UIImage *)image error:(nullable NSError *)error {
    if ([[self.collectionView indexPathsForVisibleItems] containsObject:ip]) {
        FlickrImageCell *cell = (FlickrImageCell *)[self.collectionView cellForItemAtIndexPath:ip];
        [cell setImage:image];
    }
}

#pragma mark - searchbar delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.photoSearchViewModel.searchText = searchBar.text;
    self.noDataLabel.text = @"Loading...";
    [self.collectionView reloadData];
    self.title = searchBar.text;
    [self.navigationItem.searchController setActive:NO];
}

@end
