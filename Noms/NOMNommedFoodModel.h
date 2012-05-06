//
//  NOMNommedFoododel.h
//  Noms
//
//  Created by Aaron Vasquez on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NOMNommedFoodModel : NSObject

@property (strong, nonatomic, readonly) NSURL *imageURL;
@property (strong, nonatomic, readonly) NSURL *thumbnailImageURL;

- (id)initWithAttributes:(NSDictionary *)attributes;
+ (void)photosForMenuItem:(NSDictionary *)menuItem block:(void (^)(NSSet *photos, NSError *error))block;
+ (void)uploadNomWithImage:(UIImage *)image 
                   comment:(NSString *)comment 
                     block:(void(^)(NOMNommedFoodModel *nommedFood, NSError *error))block;

@end
