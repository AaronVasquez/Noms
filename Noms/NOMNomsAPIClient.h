//
//  NOMNomsAPIClient.h
//  Noms
//
//  Created by Aaron Vasquez on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface NOMNomsAPIClient : AFHTTPClient

+ (NOMNomsAPIClient *)sharedClient;

@end
