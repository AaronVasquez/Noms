//
//  NOMFindRestaurantsViewController.m
//  Noms
//
//  Created by Aaron Vasquez on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NOMFindRestaurantsViewController.h"
#import "NOMRestaurantsViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface NOMFindRestaurantsViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *myLocation;

@end

@implementation NOMFindRestaurantsViewController 
@synthesize locationManager = _locationManager;
@synthesize myLocation = _myLocation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload {
    self.locationManager = nil;
    self.myLocation = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Controller methods

- (IBAction)findRestaurants {
    // update currCoordinate
    self.myLocation = nil;
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
}

#pragma mark - CoreLocation Delegate

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    [self.locationManager stopUpdatingLocation]; // only want to get location once
    self.myLocation = newLocation;
   
    // perform segue and pass the current location information
    [self performSegueWithIdentifier:@"showRestaurants" sender:self];
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NOMRestaurantsViewController *destinationController = segue.destinationViewController;
    destinationController.currLocation = self.myLocation; // pass current location
}


@end
