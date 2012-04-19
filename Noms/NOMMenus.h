//
//  NOMMenus.h
//  Noms
//
//  Created by Aaron Vasquez on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NOMMenus : NSObject

- (id) initWithRestaurant:(NSDictionary *)restaurant;

//  change these to be properties
- (NSString *) menuTitle;
- (NSString *) sectionTitle:(NSInteger)sectionIndex;
- (NSInteger) numberOfSections;
- (NSInteger) numberOfEntriesInSection:(NSInteger)sectionIndex;
// can select name and price of dish
- (NSDictionary *) dishAtSection:(NSInteger)section andRow:(NSInteger)row;

@end
