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

// delete these mother fuckers later
//@property (weak, nonatomic) NSMutableArray *testPhotosArray1; 
//@property (weak, nonatomic) NSMutableArray *testPhotosArray2;
//@property (weak, nonatomic) NSMutableArray *testCommentsArray1;
//@property (weak, nonatomic) NSMutableArray *testCommentsArray2;
@property (weak, nonatomic) NSMutableArray *testNommedArray1;
@property (weak, nonatomic) NSMutableArray *testNommedArray2;


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

//@synthesize testPhotosArray1 = _testPhotosArray1;
//@synthesize testPhotosArray2 = _testPhotosArray2;
//@synthesize testCommentsArray1 = _testCommentsArray1;
//@synthesize testCommentsArray2 = _testCommentsArray2;
@synthesize testNommedArray1 = _testNommedArray1;
@synthesize testNommedArray2 = _testNommedArray2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initTestData {
    // init an array of images to test...
    NOMNommedFoodModel *food1Dish1 = [[NOMNommedFoodModel alloc] init];
    NOMNommedFoodModel *food2Dish1 = [[NOMNommedFoodModel alloc] init];
    NOMNommedFoodModel *food3Dish1 = [[NOMNommedFoodModel alloc] init];
    //    NOMNommedFoodModel *food1Dish2 = [[NOMNommedFoodModel alloc] init];
    //    NOMNommedFoodModel *food2Dish2 = [[NOMNommedFoodModel alloc] init];
    //    NOMNommedFoodModel *food3Dish2 = [[NOMNommedFoodModel alloc] init];
    
    food1Dish1.image = [UIImage imageNamed:@"in n out burger.jpg"];
    food2Dish1.image = [UIImage imageNamed:@"Animal_Style_Fries.jpg"];
    food3Dish1.image = [UIImage imageNamed:@"shake.jpg"];
    
    food1Dish1.comment = @"This is an In-N-Out double double animal style. It was quite the nom!";
    food2Dish1.comment = @"Animal style fries FTW!";
    food3Dish1.comment = @"Three flavors, one cup!";
    
    _testNommedArray1 = [NSMutableArray arrayWithObjects:food1Dish1, food2Dish1, food3Dish1, nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationBar.title = [self.dishDisplaying objectForKey:@"name"];
    if (![self.dishDisplaying objectForKey:@"description"]) {
        self.navigationBar.rightBarButtonItem = nil;
    }
    
    [self initTestData];
    
    // Step 1: make the dish paging scroll view
    CGRect dishPagingScrollViewFrame = [[UIScreen mainScreen] bounds];
    dishPagingScrollViewFrame.origin.x -= PADDING;
    dishPagingScrollViewFrame.size.width += 2*PADDING;
   
    self.dishPagingScrollView.frame = dishPagingScrollViewFrame;
    self.dishPagingScrollView.contentSize = CGSizeMake(dishPagingScrollViewFrame.size.width * [self.testNommedArray1 count], dishPagingScrollViewFrame.size.height);
    self.dishPagingScrollView.delegate = self;
    self.dishPagingScrollView.maximumZoomScale = 3;
 
    // add pages to scroll view
    for (int i=0; i<[self.testNommedArray1 count]; i++) {
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
    NOMNommedFoodModel *nommedFood = [self.testNommedArray1 objectAtIndex:index];
    [page displayImage:nommedFood.image];
}

@end
