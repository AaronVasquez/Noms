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
#import "ImageScrollView.h"

#define kiPhoneWidth 320

@interface NOMAugmentedMenuViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (weak, nonatomic) UIScrollView *dishPagingScrollView;
@property (weak, nonatomic) UIScrollView *photoPagingScrollView;

// delete this mother fucker later when I get my server working...
@property (weak, nonatomic) NSArray *testPhotosArray;

-(void)prepareScrollView;

@end

@implementation NOMAugmentedMenuViewController
@synthesize  menu = _menu;
@synthesize navigationBar = _navigationBar;
@synthesize dishDisplaying = _dishDisplaying;
@synthesize photosView = _photosView;
@synthesize scrollView = _scrollView;
@synthesize dishPagingScrollView = _dishPagingScrollView; // bottom layer
@synthesize photoPagingScrollView = _photoPagingScrollView; // middle layer, remove later...needs to be dynamic

@synthesize testPhotosArray = _testPhotosArray;

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
	self.navigationBar.title = [self.dishDisplaying objectForKey:@"name"];
    if (![self.dishDisplaying objectForKey:@"description"]) {
        self.navigationBar.rightBarButtonItem = nil;
    }
    
    // init an array of images to test...
    UIImage *image1 = [UIImage imageNamed:@"in_n_out_burger_cropped.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"Animal_Style_Fries.jpg"];
    UIImage *image3 = [UIImage imageNamed:@"shake.jpg"];
    self.testPhotosArray = [NSArray arrayWithObjects:image1, image2, image3, nil];
    self.photosView.image = [self.testPhotosArray objectAtIndex:2];
    
    [self prepareScrollView];
}

- (void)viewDidUnload
{
    [self setNavigationBar:nil];
    [self setScrollView:nil];
    [self setPhotosView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIScrollViewDelegate

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // index an array of pictures?
    return self.photosView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
    // reset counters?
}


#pragma mark - actions

- (IBAction)dismissView:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showDetail:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"food detail" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NOMFoodDetailViewController *destinationViewController = segue.destinationViewController;
    destinationViewController.dish = self.dishDisplaying;
}

#pragma mark - my methods

- (void) prepareScrollView {
    // multiply width by number of pictures
    self.scrollView.contentSize = CGSizeMake(kiPhoneWidth, 480);
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 1.99;
}

@end
