//
//  NOMMenus.m
//  Noms
//
//  Created by Aaron Vasquez on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NOMMenus.h"

@interface NOMMenus()

@property (nonatomic, strong) NSDictionary *restaurantInfo;
@property (nonatomic, strong) NSDictionary *menu;

@end

@implementation NOMMenus
@synthesize restaurantInfo = _restaurantInfo;
@synthesize menu = _menu;

static NSString *foursquareVenueBase = @"https://api.foursquare.com/v2/venues/";
static NSString *clientId = @"client_id=RZQ03RP5VIL21PYDAGT5A3DWYPG43PCZL1HIBAGRNVF3NMYM";
static NSString *clientSecret = @"client_secret=XJASCKD02GEOEYDFRLGXE15GW4XXAJ400Y5KKJWPEZAPYKIS";

- (NSString *)performFoursquareRequestWithURL:(NSURL *)url {
    NSError *error;
    NSString *resultString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    if (!resultString) {
        NSLog(@"Download Error: %@", error);
        return nil;
    }
    return resultString;
}

// convert JSON string to dictionary
- (NSDictionary *)parseJSON:(NSString *)jsonString {
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id resultObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (!resultObject) {
        NSLog(@"JSON Error: %@", error);
        return nil;
    }
    return  resultObject;
}

- (id) initWithRestaurant:(NSDictionary *)restaurant {
    if (self = [super init]) {
        self.restaurantInfo = restaurant;
        NSString *urlString = [NSString stringWithFormat:@"%@%@/menu?%@&%@",
                               foursquareVenueBase,
                               [self.restaurantInfo objectForKey:@"id"],
                               clientId, clientSecret];
        NSString *jsonString = [self performFoursquareRequestWithURL:[NSURL URLWithString:urlString]];
        NSDictionary *JSONResponse = [self parseJSON:jsonString];
        
        // assume only one menu for now...
        // need to catch error
        self.menu = [[[[[JSONResponse objectForKey:@"response"] 
                                      objectForKey:@"menu"] 
                                      objectForKey:@"menus"]
                                      objectForKey:@"items"]
                                      objectAtIndex:0];
    }
    return self;
}

- (NSString *)menuTitle {
    return [self.menu objectForKey:@"name"];
}

- (NSInteger) numberOfSections {
    NSString *numSections = [[self.menu objectForKey:@"entries"] objectForKey:@"count"];
    return [numSections intValue];
}

- (NSString *)sectionTitle:(NSInteger)sectionIndex {
    return [[[[self.menu objectForKey:@"entries"] 
                         objectForKey:@"items"]
                         objectAtIndex:sectionIndex] 
                         objectForKey:@"name"];
}

- (NSInteger) numberOfEntriesInSection:(NSInteger)sectionIndex {
    NSString *numEntries = [[[[[self.menu objectForKey:@"entries"] 
                                          objectForKey:@"items"]
                                          objectAtIndex:sectionIndex] 
                                          objectForKey:@"entries"] 
                                          objectForKey:@"count"];
    return [numEntries intValue];
}

// can select name and price of dish
- (NSDictionary *) dishAtSection:(NSInteger)section andRow:(NSInteger)row {
    return [[[[[[self.menu objectForKey:@"entries"] 
                           objectForKey:@"items"]
                           objectAtIndex:section] 
                           objectForKey:@"entries"] 
                           objectForKey:@"items"] 
                           objectAtIndex:row];
}






@end
