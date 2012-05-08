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

// delete these mother fuckers later
@property (strong, nonatomic) NSMutableArray *testNommedArray1;
@property (strong, nonatomic) NSMutableArray *testNommedArray2;


- (void)configurePage:(ImageScrollView *)page forIndex:(NSUInteger)index;

@end

@implementation NOMAugmentedMenuViewController
@synthesize menu = _menu;
@synthesize navigationBar = _navigationBar;
@synthesize dishDisplaying = _dishDisplaying;
@synthesize commentView = _commentView;

@synthesize testNommedArray1 = _testNommedArray1;
@synthesize testNommedArray2 = _testNommedArray2;

@synthesize dishPagingScrollView = _dishPagingScrollView; // bottom layer
@synthesize recycledDishPages = _recycledDishPages;
@synthesize visibleDishPages = _visibleDishPages;

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

- (void)initDishPagingScrollView {
    // Make the dish paging scroll view
    CGRect dishPagingScrollViewFrame = [[UIScreen mainScreen] bounds];
    dishPagingScrollViewFrame.origin.x -= PADDING;
    dishPagingScrollViewFrame.size.width += 2*PADDING;
    
    self.dishPagingScrollView = [[UIScrollView alloc] initWithFrame:dishPagingScrollViewFrame];
    self.dishPagingScrollView.pagingEnabled = YES;
    self.dishPagingScrollView.backgroundColor = [UIColor blackColor];
    // adjust size to array size
    self.dishPagingScrollView.contentSize = CGSizeMake(dishPagingScrollViewFrame.size.width * [self.testNommedArray1 count],
                                                       dishPagingScrollViewFrame.size.height);
    [self.view insertSubview:self.dishPagingScrollView atIndex:0]; // goes underneath other views
    self.dishPagingScrollView.delegate = self;
    
    self.recycledDishPages = [[NSMutableSet alloc] init];
    self.visibleDishPages = [[NSMutableSet alloc] init];
    [self tilePages];
}

- (BOOL)isDisplayingPageForIndex:(NSUInteger)index {
    BOOL foundPage = NO;
    for (ImageScrollView *page in self.visibleDishPages) {
        if (page.index == index) {
            foundPage = YES;
            break;
        }
    }
    return foundPage;
}

- (ImageScrollView *)dequeueRecycledPage {
    ImageScrollView *page = [self.recycledDishPages anyObject];
    if (page) {
        [self.recycledDishPages removeObject:page];
    }
    return page;
}

- (void) tilePages {
    // Calculate which pages should now be visible
    CGRect visibleBounds = self.dishPagingScrollView.bounds;
    int firtNeededPageIndex = floorf(CGRectGetMinX(visibleBounds) / CGRectGetWidth(visibleBounds));
    int lastNeededPageIndex = floorf((CGRectGetMaxX(visibleBounds)-1) / CGRectGetWidth(visibleBounds));
    firtNeededPageIndex = MAX(firtNeededPageIndex, 0);
    lastNeededPageIndex = MIN(lastNeededPageIndex, [self.testNommedArray1 count]-1);
    
    // Recycle no=longer-needed pages
    for (ImageScrollView *dishPage in self.visibleDishPages) {
        if (dishPage.index < firtNeededPageIndex || dishPage.index > lastNeededPageIndex) {
            [self.recycledDishPages addObject:dishPage];
            [dishPage removeFromSuperview];
        }
    }
    [self.visibleDishPages minusSet:self.recycledDishPages];
    
    // Add missing pages
    for (int index = firtNeededPageIndex; index<=lastNeededPageIndex; index++) {
        if (![self isDisplayingPageForIndex:index]) {
            ImageScrollView *page = [self dequeueRecycledPage];
            if (page == nil) {
                page = [[ImageScrollView alloc] init];
            }
            [self configurePage:page forIndex:index];
            [self.dishPagingScrollView addSubview:page];
            [self.visibleDishPages addObject:page];
        }
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationBar.title = [self.dishDisplaying objectForKey:@"name"];
    if (![self.dishDisplaying objectForKey:@"description"]) {
        self.navigationBar.rightBarButtonItem = nil;
    }
    
    [self initTestData];
    [self initDishPagingScrollView];
    
    // set up first nommed food
    NOMNommedFoodModel *firstNom = [self.testNommedArray1 objectAtIndex:0];
    self.commentView.text = firstNom.comment;
}

- (void)viewDidUnload
{
    self.testNommedArray1 = nil;
    self.testNommedArray2 = nil;
    [self setNavigationBar:nil];
    [self setDishPagingScrollView:nil];
    [self setCommentView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    static NSInteger previousPage = 0;
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    if (previousPage != page) {
        //set the comment to the appropriate one
        NOMNommedFoodModel *nommedFood = [self.testNommedArray1 objectAtIndex:page];
        self.commentView.text = nommedFood.comment;
        previousPage = page;
    }
    [self tilePages];
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
