//
//  NOMAddNomViewController.h
//  Noms
//
//  Created by Aaron Vasquez on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NOMAddNomViewController : UIViewController
@property (weak, nonatomic) NSDictionary *restaurant; // JSON Object
@property (weak, nonatomic) NSString *dish; //JSON Object

- (IBAction)dismissView:(id)sender;
- (IBAction)addPhoto:(id)sender;

@end
