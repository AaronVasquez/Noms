//
//  NOMNommedFoodModel.m
//  Noms
//
//  Created by Aaron Vasquez on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NOMNommedFoodModel.h"
#import "AFHTTPClient.h"

@interface NOMNommedFoodModel()

@property (strong, nonatomic) NSDictionary *dishItem; // from Foursquare API (need to store Id in cloud

@end

@implementation NOMNommedFoodModel
@synthesize nomment = _nomment;
@synthesize dishItem = _dishItem;
@synthesize image = _image;

#define NOM_SERVER @"http://nombomb.herokuapp.com/"
#define NOM_DEV_SERVER @"http://localhost:5000/"
#define CREATE_PHOTO_PATH @"photos"

- (NSString *) getDishTitle {
    return @"insert here"; // get title from dishItem dictionary
}

- (id) initWith:(NSDictionary *)dish {
    if (self = [super init]) {
        self.dishItem = dish;
    }
    return self;
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
 
//    CREATE PARAMETERS DICTIONARY: restaurant ID, Menu ID, Dish ID
 
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionary];
 [mutableParameters setObject:[NSNumber numberWithDouble:location.coordinate.latitude] forKey:@"photo[lat]"];
 [mutableParameters setObject:[NSNumber numberWithDouble:location.coordinate.longitude] forKey:@"photo[lng]"];
 
//    CREATE URLREQUEST
    NSMutableURLRequest *mutableURLRequest = [[GeoPhotoAPIClient sharedClient] multipartFormRequestWithMethod:@"POST" path:@"/photos" parameters:mutableParameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.8) name:@"photo[image]" fileName:@"image.jpg" mimeType:@"image/jpeg"];
    }];
//    HTTP REQUEST (POST)
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

- (id)jsonPostRequest:(NSData *)jsonRequestData {
    // create URLRequest
    NSURL *url = [NSURL URLWithString:[NOM_DEV_SERVER stringByAppendingFormat:CREATE_PHOTO_PATH]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    // bind request with jsonRequestData
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [jsonRequestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:jsonRequestData];
    
    // send synchronous request (make asynchronous later...)
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (!error) {
        return result;
    }
    return nil;
}

#pragma mark - Public API
- (void)uploadNomToServer {  // completion:(void (^)(Photo *photo, NSError *error))block;

    // create parameters dictionary
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                //UIImagePNGRepresentation(self.image), @"image",
                                 
                                self.nomment, @"comment",
                                 nil];
    
    NSDictionary *jsonDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              parameters, @"photo",
                              nil]; // argh, need to refactor title this on the rails side...
    // foursquare IDs to params
    NSLog(@"%@", jsonDict);
    
    // convert to json
    if ([NSJSONSerialization isValidJSONObject:jsonDict]) {
        NSLog(@"serialized...");
        NSError *error = nil;
        NSData *result = [NSJSONSerialization dataWithJSONObject:jsonDict options:kNilOptions error:&error];
        if (error || !result) {
            NSLog(@"error converting json to params hash");
        } else {
            NSLog(@"now sending...");
            [self jsonPostRequest:result]; // indicate success or not...
        }
    } else {
        NSLog(@"fuck...");
    }
    NSLog(@"submitted??");
}

@end









