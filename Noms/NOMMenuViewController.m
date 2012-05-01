//
//  NOMMenuViewController.m
//  Noms
//
//  Created by Aaron Vasquez on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NOMMenuViewController.h"
#import "NOMMenus.h"
#import "NOMAddNomViewController.h"
#import "NOMAugmentedMenuViewController.h"

@interface NOMMenuViewController () 

@property (nonatomic, strong) NOMMenus *menu;
@property (nonatomic, weak) NSString *currDishTitle;

@end

@implementation NOMMenuViewController
@synthesize restaurantInfo = _restaurantInfo;
@synthesize menu = _menu;
@synthesize currDishTitle = _currDishTitle;

// custom getter
- (NOMMenus *)menu {
    if (!_menu) {
        _menu = [[NOMMenus alloc] initWithRestaurant:self.restaurantInfo];
    }
    return _menu;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:style]) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [self.menu menuTitle];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.menu numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menu numberOfEntriesInSection:section];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

#define TITLE_TAG 1
#define PRICE_TAG 2
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dish with camera"];
    // need to clean up later and put in model
    UILabel *title = (UILabel *)[cell viewWithTag:TITLE_TAG];
    UILabel *price = (UILabel *)[cell viewWithTag:PRICE_TAG];
    title.text = [self.menu dishTitleAtSection:indexPath.section andRow:indexPath.row];
    price.text = [self.menu priceAtSection:indexPath.section andRow:indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.menu sectionTitle:section];
}


#pragma mark - Table view delegate

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
*/

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"augmented menu"]) {
        // pass menu and current dish
    } else if ([segue.identifier isEqualToString:@"add nom"]) {
        // pass restaurant
        UIButton *button = (UIButton *)sender;
        UITableViewCell *cell = (UITableViewCell *)button.superview.superview; // not sure why I had to do this...
        UITableView *tableView = (UITableView *)cell.superview;
        NSIndexPath *indexPath = [tableView indexPathForCell:cell];
        NOMAddNomViewController *destinationViewController =  segue.destinationViewController;
        destinationViewController.restaurant = self.restaurantInfo;
        destinationViewController.dish = [self.menu dishTitleAtSection:indexPath.section andRow:indexPath.row];
    }
}

#pragma mark - methods

@end
