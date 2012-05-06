//
//  NOMNomsAPIClient.m
//  Noms
//
//  Created by Aaron Vasquez on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NOMNomsAPIClient.h"
#import "AFJSONRequestOperation.h"

#define kNomsBaseURL @"http://nombomb.herokuapp.com"
#define kNomsBaseURL_Dev @"http://localhost:5000"
#define kNomsCreatePhotoPath @"photos.json"

@implementation NOMNomsAPIClient

+ (NOMNomsAPIClient *)sharedClient {
    static NOMNomsAPIClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kNomsBaseURL_Dev]];
    });
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    //accept HTTP Header
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    return self;
}

@end
