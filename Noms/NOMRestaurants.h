//
//  NOMRestaurants.h
//  Noms
//
//  Created by Aaron Vasquez on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface NOMRestaurants : NSObject <NSURLConnectionDelegate>

- (NSArray *)getRestaurantsAt: (CLLocation *)location;

@end
