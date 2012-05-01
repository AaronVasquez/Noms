//
//  NOMFoodDetailViewController.h
//  Noms
//
//  Created by Aaron Vasquez on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NOMFoodDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *foodTitle;
@property (weak, nonatomic) IBOutlet UILabel *foodDescription;
@property (weak, nonatomic) IBOutlet UILabel *foodPrices;
- (IBAction)dissmissView:(UIBarButtonItem *)sender;
@end
