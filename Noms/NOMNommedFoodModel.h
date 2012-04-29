//
//  NOMNommedFoododel.h
//  Noms
//
//  Created by Aaron Vasquez on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NOMNommedFoodModel : NSObject

@property (strong, nonatomic) NSString *comment;

- (NSString *)getDishTitle;

+ (void)uploadPhotoWithImage:(UIImage *)image 
                     comment:(NSString *)comment; // completion:(void (^)(Photo *photo, NSError *error))block;

@end
