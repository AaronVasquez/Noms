//
//  NOMFoodDetailViewController.m
//  Noms
//
//  Created by Aaron Vasquez on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NOMFoodDetailViewController.h"
#import "NOMMenus.h"

@interface NOMFoodDetailViewController ()

@property (weak, nonatomic) NOMMenus *menu;
- (NSString *) displayPrices;

@end

@implementation NOMFoodDetailViewController
@synthesize foodTitle = _foodTitle;
@synthesize foodDescription = _foodDescription;
@synthesize foodPrices = _foodPrices;
@synthesize menu = _menu;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.foodTitle.text;
    self.foodDescription.text;
    self.foodPrices.text = [self displayPrices];
}

- (void)viewDidUnload
{
    [self setFoodTitle:nil];
    [self setFoodDescription:nil];
    [self setFoodPrices:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)dissmissView:(UIBarButtonItem *)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (NSString *) displayPrices {
    
}

@end
