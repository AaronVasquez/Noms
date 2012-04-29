//
//  NOMNommedFoodModel.m
//  Noms
//
//  Created by Aaron Vasquez on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NOMNommedFoodModel.h"

@interface NOMNommedFoodModel()

@property (strong, nonatomic) NSDictionary *dishItem; // from Foursquare API (need to store Id in cloud

@end

@implementation NOMNommedFoodModel
@synthesize comment = _comment;
@synthesize dishItem = _dishItem;

#define NOM_SERVER @"http://nombomb.herokuapp.com/"

- (NSString *) getDishTitle {
    return @"insert here"; // get title from dishItem dictionary
}


//    self.title = NSLocalizedString(@"GeoPhoto", nil);
//    
//    NSURL *url = [NSURL URLWithString:@"http://localhost:5000/photos.json"];
//    [[AFJSONRequestOperation JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:url] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//        for (NSDictionary *attributes in [JSON valueForKeyPath:@"photos"]) {
//            Photo *photo = [[[Photo alloc] initWithAttributes:attributes] autorelease];
//            [self.mapView addAnnotation:photo];
//        }
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//        NSLog(@"Error: %@", error);
//    }] start];

@end
