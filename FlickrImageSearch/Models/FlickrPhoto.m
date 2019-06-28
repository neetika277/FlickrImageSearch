//
//  FlickrPhoto.m
//  FlickrImageSearch
//
//  Created by Neetika on 27/06/19.
//  Copyright © 2019 Neetika. All rights reserved.
//

#import "FlickrPhoto.h"

@implementation FlickrPhoto

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.photoId = dictionary[@"id"];
        self.owner = dictionary[@"owner"];
        self.secret = dictionary[@"secret"];
        self.server = dictionary[@"server"];
        self.title = dictionary[@"title"];
        self.isFriend = [dictionary[@"isfriend"] boolValue];
        self.isFamily = [dictionary[@"isfamily"] boolValue];
        self.farm = [dictionary[@"farm"] integerValue];
        self.isPublic = [dictionary[@"ispublic"] boolValue];
    }
    return self;
}

@end
