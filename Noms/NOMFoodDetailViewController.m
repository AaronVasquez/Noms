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

- (NSString *) displayPrices;

@end

@implementation NOMFoodDetailViewController
@synthesize foodTitle = _foodTitle;
@synthesize foodDescription = _foodDescription;
@synthesize foodPrices = _foodPrices;
@synthesize dish = _dish;

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
    NSLog(@"%@", self.dish);
    self.foodTitle.text = [self.dish objectForKey:@"name"];
    self.foodDescription.text = [self.dish objectForKey:@"description"];
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
    NSString *priceList = [[NSString alloc] initWithString:@""];
    for (NSString *price in [self.dish objectForKey:@"prices"]) {
        priceList = [priceList stringByAppendingFormat:@"\n%@", price];
    }
    return priceList;
}

@end
