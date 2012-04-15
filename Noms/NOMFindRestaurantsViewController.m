//
//  NOMFindRestaurantsViewController.m
//  Noms
//
//  Created by Aaron Vasquez on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NOMFindRestaurantsViewController.h"

@interface NOMFindRestaurantsViewController ()

@end

@implementation NOMFindRestaurantsViewController
@synthesize locationCoordinates = _locationCoordinates;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"whatup yo");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload {
    [self setLocationCoordinates:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - CoreLocation Delegate

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    [self.locationCoordinates stopUpdatingLocation]; // only want to get location once
    CLLocationCoordinate2D currCoordinate = newLocation.coordinate;
    NSLog(@"Latitude: %f", currCoordinate.latitude);
    NSLog(@"Longitude: %f", currCoordinate.longitude);
    
}

#pragma mark - actions

- (IBAction)findRestaurants {
    self.locationCoordinates.delegate = self;
    [self.locationCoordinates startUpdatingLocation];
}

@end
