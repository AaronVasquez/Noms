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

/* call when submitting stuff
 [Photo uploadPhotoAtLocation:self.locationManager.location image:image block:^(Photo *photo, NSError *error) {
 if (error) {
 [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Upload Failed", nil) message:[error localizedFailureReason] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil] show];
 } else {
 [self.mapView addAnnotation:photo];
 }
 }];
 */

/*
+ (void)uploadPhotoAtLocation:(CLLocation *)location
                        image:(UIImage *)image
                        block:(void (^)(Photo *photo, NSError *error))block
{
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionary];
    [mutableParameters setObject:[NSNumber numberWithDouble:location.coordinate.latitude] forKey:@"photo[lat]"];
    [mutableParameters setObject:[NSNumber numberWithDouble:location.coordinate.longitude] forKey:@"photo[lng]"];
    
    NSMutableURLRequest *mutableURLRequest = [[GeoPhotoAPIClient sharedClient] multipartFormRequestWithMethod:@"POST" path:@"/photos" parameters:mutableParameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.8) name:@"photo[image]" fileName:@"image.jpg" mimeType:@"image/jpeg"];
    }];
    
    AFHTTPRequestOperation *operation = [[GeoPhotoAPIClient sharedClient] HTTPRequestOperationWithRequest:mutableURLRequest success:^(AFHTTPRequestOperation *operation, id JSON) {
        Photo *photo = [[[Photo alloc] initWithAttributes:[JSON valueForKeyPath:@"photo"]] autorelease];
        
        if (block) {
            block(photo, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
    [[GeoPhotoAPIClient sharedClient] enqueueHTTPRequestOperation:operation];
}
*/

/* called this when new location found from CLManager
+ (void)photosNearLocation:(CLLocation *)location
                     block:(void (^)(NSSet *photos, NSError *error))block
{
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionary];
    [mutableParameters setObject:[NSNumber numberWithDouble:location.coordinate.latitude] forKey:@"lat"];
    [mutableParameters setObject:[NSNumber numberWithDouble:location.coordinate.longitude] forKey:@"lng"];
    
    [[GeoPhotoAPIClient sharedClient] getPath:@"/photos" parameters:mutableParameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSMutableSet *mutablePhotos = [NSMutableSet set];
        for (NSDictionary *attributes in [JSON valueForKeyPath:@"photos"]) {
            Photo *photo = [[[Photo alloc] initWithAttributes:attributes] autorelease];
            [mutablePhotos addObject:photo];
        }
        
        if (block) {
            block([NSSet setWithSet:mutablePhotos], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}
*/

/*
    self.title = NSLocalizedString(@"GeoPhoto", nil);
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:5000/photos.json"];
    [[AFJSONRequestOperation JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:url] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        for (NSDictionary *attributes in [JSON valueForKeyPath:@"photos"]) {
            Photo *photo = [[[Photo alloc] initWithAttributes:attributes] autorelease];
            [self.mapView addAnnotation:photo];
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Error: %@", error);
    }] start];
*/

/*
- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}
*/

#pragma mark - Helper Methods



#pragma mark - Public API
+ (void)uploadPhotoWithImage:(UIImage *)image 
                     comment:(NSString *)comment{} // completion:(void (^)(Photo *photo, NSError *error))block;

@end
