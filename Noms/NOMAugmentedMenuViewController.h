//
//  NOMAugmentedMenuViewController.h
//  Noms
//
//  Created by Aaron Vasquez on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NOMAugmentedMenuViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) NSDictionary *menu;
@property (weak, nonatomic) NSDictionary *dishDisplaying;
@property (weak, nonatomic) IBOutlet UILabel *commentView;
- (IBAction)dismissView:(id)sender;
- (IBAction)showDetail:(UIBarButtonItem *)sender;

@end
