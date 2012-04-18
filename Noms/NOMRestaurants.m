//
//  NOMRestaurants.m
//  Noms
//
//  Created by Aaron Vasquez on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NOMRestaurants.h"

@interface NOMRestaurants() 

@property (strong, nonatomic) NSMutableData *downloadedData;
@property (strong, nonatomic) NSArray *JSONRestaurants; // can access name and menu from this dict

@end

@implementation NOMRestaurants 

@synthesize downloadedData = _downloadedData;
@synthesize JSONRestaurants = _JSONRestaurants;

static NSString *foursquareVenueBase = @"https://api.foursquare.com/v2/venues/search";
static NSString *foursquareFoodCategory = @"categoryId=4d4b7105d754a06374d81259"; // might change...need to update once in a while
static NSString *clientId = @"client_id=RZQ03RP5VIL21PYDAGT5A3DWYPG43PCZL1HIBAGRNVF3NMYM";
static NSString *clientSecret = @"client_secret=XJASCKD02GEOEYDFRLGXE15GW4XXAJ400Y5KKJWPEZAPYKIS";

- (void)fetchData:(NSString *)dataPath {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:dataPath] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (NSURL *)urlWithLocation:(CLLocation *)location {
    NSString *urlString = [NSString stringWithFormat:@"%@?%@&%@&%@&ll=%f,%f",
                           foursquareVenueBase, clientId, clientSecret, foursquareFoodCategory,
                           location.coordinate.latitude, location.coordinate.longitude];
    NSLog(@"%@", urlString);
    return [NSURL URLWithString:urlString];
}

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

- (NSArray *)getRestaurantsAt: (CLLocation *)location {
    NSURL *url = [self urlWithLocation:location];
    NSString *jsonString = [self performFoursquareRequestWithURL:url];
    NSDictionary *JSONRespnse = [self parseJSON:jsonString];
    self.JSONRestaurants = [[[[JSONRespnse objectForKey:@"response"] objectForKey:@"groups"] objectAtIndex:0] objectForKey:@"items"];
    
    return [self.JSONRestaurants copy];
}

-(NSMutableArray *)getArrayOfRestaurants {
    NSMutableArray *restaurants = [[NSMutableArray alloc] init];
    
    
    
    return restaurants;
}



@end
