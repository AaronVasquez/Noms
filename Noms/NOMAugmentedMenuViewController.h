//
//  NOMAugmentedMenuViewController.h
//  Noms
//
//  Created by Aaron Vasquez on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageScrollView.h"

@interface NOMAugmentedMenuViewController : UIViewController <UIScrollViewDelegate>

// move to own class
@property (strong, nonatomic) UIScrollView *dishPagingScrollView;
@property (strong, nonatomic) NSMutableSet *recycledDishPages;
@property (strong, nonatomic) NSMutableSet *visibleDishPages;
- (ImageScrollView *)dequeueRecycledDishPage;
- (void)tilePages;

@property (strong, nonatomic) NSDictionary *menu;
@property (weak, nonatomic) NSDictionary *dishDisplaying;
@property (weak, nonatomic) IBOutlet UILabel *commentView;
- (IBAction)dismissView:(id)sender;
- (IBAction)showDetail:(UIBarButtonItem *)sender;

@end
