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

#define PADDING  10
#define kiPhoneWidth 320
#define kiPhoneHeight 480

@interface NOMAugmentedMenuViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (weak, nonatomic) IBOutlet UIScrollView *dishPagingScrollView;
@property (weak, nonatomic) UIScrollView *photoPagingScrollView;

@property (weak, nonatomic) NSMutableArray *testPhotosArray; // delete this mother fucker later

- (void)configurePage:(ImageScrollView *)page forIndex:(NSUInteger)index;

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
    UIImage *image1 = [UIImage imageNamed:@"in_n_out_burger.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"Animal_Style_Fries.jpg"];
    UIImage *image3 = [UIImage imageNamed:@"shake.jpg"];
    _testPhotosArray = [NSMutableArray arrayWithObjects:image1, image2, image3, nil];
//    self.photosView.image = [self.testPhotosArray objectAtIndex:0];
    
    // Step 1: make the dish paging scroll view
    CGRect dishPagingScrollViewFrame = [[UIScreen mainScreen] bounds];
    dishPagingScrollViewFrame.origin.x -= PADDING;
    dishPagingScrollViewFrame.size.width += 2*PADDING;
   
    self.dishPagingScrollView.frame = dishPagingScrollViewFrame;
    self.dishPagingScrollView.contentSize = CGSizeMake(dishPagingScrollViewFrame.size.width * [self.testPhotosArray count], dishPagingScrollViewFrame.size.height);
    self.dishPagingScrollView.delegate = self;
    self.dishPagingScrollView.maximumZoomScale = 3;
 
    // add pages to scroll view
    for (int i=0; i<[self.testPhotosArray count]; i++) {
        ImageScrollView *page = [[ImageScrollView alloc] init];
        [self configurePage:page forIndex:i];
        page.clipsToBounds = YES;
        [self.dishPagingScrollView addSubview:page];
    }
}

- (void)viewDidUnload
{
    [self setNavigationBar:nil];
    [self setScrollView:nil];
    [self setPhotosView:nil];
    [self setDishPagingScrollView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIScrollViewDelegate
//
//-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
//    // index an array of pictures?
//    return scrollView;
//}

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

#pragma mark  Frame calculations

  
- (CGRect)frameForPagingScrollView {
    CGRect frame = [[UIScreen mainScreen] bounds];
    frame.origin.x -= PADDING;
    frame.size.width += (2 * PADDING);
    return frame;
}
         
- (CGRect)frameForPageAtIndex:(NSUInteger)index {
    CGRect pagingScrollViewFrame = [self frameForPagingScrollView];
    
    CGRect pageFrame = pagingScrollViewFrame;
    pageFrame.size.width -= (2 * PADDING);
    pageFrame.origin.x = (pagingScrollViewFrame.size.width * index) + PADDING;
    return pageFrame;
}
         
#pragma mark - my methods

- (void)configurePage:(ImageScrollView *)page forIndex:(NSUInteger)index {
    page.index = index;
    page.frame = [self frameForPageAtIndex:page.index];
    
//   // Use tiled images
//   [page displayTiledImageNamed:[self imageNameAtIndex:index]
//                            size:[self imageSizeAtIndex:index]];
//    
//   // To use full images instead of tiled images, replace the "displayTiledImageNamed:" call
//   // above by the following line:
//   [page displayImage:[self imageAtIndex:index]];
    
     [page displayImage:[self.testPhotosArray objectAtIndex:index]];
}

@end
