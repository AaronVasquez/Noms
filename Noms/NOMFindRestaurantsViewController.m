//
//  NOMFindRestaurantsViewController.m
//  Noms
//
//  Created by Aaron Vasquez on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NOMFindRestaurantsViewController.h"
#import "NOMRestaurantsViewController.h"

@interface NOMFindRestaurantsViewController ()

@end

@implementation NOMFindRestaurantsViewController {
    CLLocation *currLocation;
}
@synthesize locationCoordinates = _locationCoordinates;

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
    currLocation = newLocation;
   
    // perform segue and pass the current location information
    [self performSegueWithIdentifier:@"showRestaurants" sender:self];
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NOMRestaurantsViewController *destinationController = segue.destinationViewController;
    destinationController.currLocation = currLocation; // pass current location
}

- (IBAction)findRestaurants {
    // update currCoordinate
    currLocation = nil;
    self.locationCoordinates.delegate = self;
    [self.locationCoordinates startUpdatingLocation];
    
}

@end
