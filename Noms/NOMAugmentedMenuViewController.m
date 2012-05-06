//
//  NOMAugmentedMenuViewController.m
//  Noms
//
//  Created by Aaron Vasquez on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NOMAugmentedMenuViewController.h"
#import "NOMNommedFoodModel.h"
#import "NOMFoodDetailViewController.h"

@interface NOMAugmentedMenuViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;

@end

@implementation NOMAugmentedMenuViewController
@synthesize navigationBar = _navigationBar;
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
	self.navigationBar.title = [self.dish objectForKey:@"name"];
    if (![self.dish objectForKey:@"description"]) {
        self.navigationBar.rightBarButtonItem = nil;
    }
}

- (void)viewDidUnload
{
    [self setNavigationBar:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)dismissView:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showDetail:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"food detail" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NOMFoodDetailViewController *destinationViewController = segue.destinationViewController;
    destinationViewController.dish = self.dish;
}
@end
