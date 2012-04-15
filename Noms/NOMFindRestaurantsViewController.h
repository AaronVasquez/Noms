//
//  NOMFindRestaurantsViewController.h
//  Noms
//
//  Created by Aaron Vasquez on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// this is a temporary controller & view to get locations, will be replaced when I implement new features
// pressing the tab bar button will serve the same function as this button

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface NOMFindRestaurantsViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet CLLocationManager *locationCoordinates;
- (IBAction)findRestaurants;

@end