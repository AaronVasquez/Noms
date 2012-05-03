//
//  NOMNommedFoododel.h
//  Noms
//
//  Created by Aaron Vasquez on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NOMNommedFoodModel : NSObject

@property (weak, nonatomic) NSString *nomment;
@property (weak, nonatomic) UIImage *image;

- (NSString *)getDishTitle;
- (id) initWith:(NSDictionary *)dish;

- (void)uploadNomToServer; // completion:(void (^)(Photo *photo, NSError *error))block;

@end
