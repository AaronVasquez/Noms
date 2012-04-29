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

- (void)fetchData:(NSString *)dataPath {
    
#define FOURSQ_VENUES @"https://api.foursquare.com/v2/venues/search"
#define FOURSQ_FOOD @"categoryId=4d4b7105d754a06374d81259"
#define CLIENT_ID @"client_id=RZQ03RP5VIL21PYDAGT5A3DWYPG43PCZL1HIBAGRNVF3NMYM"
#define CLIENT_SECRET @"client_secret=XJASCKD02GEOEYDFRLGXE15GW4XXAJ400Y5KKJWPEZAPYKIS"
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:dataPath] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (NSURL *)urlWithLocation:(CLLocation *)location {
    NSString *urlString = [NSString stringWithFormat:@"%@?%@&%@&%@&ll=%f,%f",
                           FOURSQ_VENUES, CLIENT_ID, CLIENT_SECRET, FOURSQ_FOOD,
                           location.coordinate.latitude, location.coordinate.longitude];
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

@end
