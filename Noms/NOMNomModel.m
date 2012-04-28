//
//  NOMNomModel.m
//  Noms
//
//  Created by Aaron Vasquez on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NOMNomModel.h"

@interface NOMNomModel()

@property (strong, nonatomic) NSDictionary *dishItem; // from Foursquare API (need to store Id in cloud

@end

@implementation NOMNomModel
@synthesize comment = _comment;
@synthesize dishItem = _dishItem;

- (NSString *) getDishTitle {
    return @"insert here"; // get title from dishItem dictionary
}

@end
