//
//  NOMNommedFoodModel.m
//  Noms
//
//  Created by Aaron Vasquez on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NOMNommedFoodModel.h"
#import "NOMNomsAPIClient.h"

@interface NOMNommedFoodModel()
@property (strong, nonatomic, readwrite) NSString *imageURLString;
@property (strong, nonatomic, readwrite) NSString *thumbnailImageURLString;

@end

@implementation NOMNommedFoodModel
@synthesize imageURLString = _imageURLString;
@synthesize thumbnailImageURLString = _thumbnailImageURLString;
@dynamic imageURL;

@synthesize image = _image;
@synthesize comment = _comment;

static CGFloat const kPhotoJPEGQuality = 0.6;

#pragma mark - custom getters and setters

- (NSURL *)imageURL {
    return [NSURL URLWithString:self.imageURLString];
}

- (NSURL *)thumbnailImageURL {
    return [NSURL URLWithString:self.thumbnailImageURLString];
}

#pragma mark - public API

- (id)initWithAttributes:(NSDictionary *)attributes{
    if (!(self = [super init])) {
        return nil;
    }
    // set URLStrings for properties
    self.imageURLString = [attributes valueForKeyPath:@"image_urls.original"];
    self.thumbnailImageURLString = [attributes valueForKeyPath:@"image_urls.thumbnail"];
    return self;
}

+ (void)photosForMenuItem:(NSDictionary *)menuItem block:(void (^)(NSSet *photos, NSError *error))block {

}

+ (void)uploadNomWithImage:(UIImage *)image comment:(NSString *)comment block:(void(^)(NOMNommedFoodModel *nommedFood, NSError *error))block {
    // create dictionary
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionaryWithCapacity:1];
    [mutableParameters setObject:comment forKey:@"comment"];
    // later add in foursquare IDs to reference...
    
    // create request
    NSMutableURLRequest *mutableURLRequest = [[NOMNomsAPIClient sharedClient] 
                                              multipartFormRequestWithMethod:@"POST" 
                                              path:@"/photos.json"
                                              parameters:mutableParameters
                                              constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                  [formData appendPartWithFileData:UIImageJPEGRepresentation(image, kPhotoJPEGQuality) name:@"photo[image]" fileName:@"image.jpg" mimeType:@"image/jpeg"];
                                              }];
    
    NSLog(@"creating operation");
    // create operation
    AFHTTPRequestOperation *operation = [[NOMNomsAPIClient sharedClient] 
                                         HTTPRequestOperationWithRequest:mutableURLRequest 
                                         success:^(AFHTTPRequestOperation *operation, id JSON) {
                                             // change JSON key when refactor rails table name!!!!!!
                                             NOMNommedFoodModel *nommedFood = [[NOMNommedFoodModel alloc] initWithAttributes:[JSON valueForKey:@"photo"]];
                                             if (block) {
                                                 block(nommedFood, nil);
                                             }
                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             if (block) {
                                                 block(nil,error);
                                             }
                                         }];
    
    NSLog(@"doing background operation");
    // do operation in background
    [[NOMNomsAPIClient sharedClient] enqueueHTTPRequestOperation:operation];
}

@end









