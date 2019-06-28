//
//  FlickrConstants.h
//  FlickrImageSearch
//
//  Created by Neetika on 27/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#ifndef FlickrConstants_h
#define FlickrConstants_h

#define kFlickrAPIKey @"3e7cc266ae2b0e0d78e279ce8e361736"
#define kFlickrPhotoSearchUrl @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&format=json&nojsoncallback=1&safe_search=1&text=%@&page=%@"
#define kFlickrPhotoDownloadUrl @"https://farm%@.static.flickr.com/%@/%@_%@.jpg"

#endif /* FlickrConstants_h */
