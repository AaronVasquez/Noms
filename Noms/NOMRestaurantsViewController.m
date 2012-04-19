//
//  NOMRestaurantsViewController.m
//  Noms
//
//  Created by Aaron Vasquez on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NOMRestaurantsViewController.h"
#import "NOMRestaurants.h"
#import "NOMMenuViewController.h"

@interface NOMRestaurantsViewController ()

@property (strong, nonatomic) NOMRestaurants *nearbyRestaurants;
@property (strong, nonatomic) NSArray *listOfRestaurants;
@property (strong, nonatomic) NSDictionary *selectedRestaurant;

@end

@implementation NOMRestaurantsViewController 
@synthesize currLocation = _currLocation;
@synthesize nearbyRestaurants = _nearbyRestaurants;
@synthesize listOfRestaurants = _listOfRestaurants;
@synthesize selectedRestaurant = _selectedRestaurant;

// custom getter for lazy loading
- (NOMRestaurants *)nearbyRestaurants {
    if (!_nearbyRestaurants) _nearbyRestaurants = [[NOMRestaurants alloc] init];
    return _nearbyRestaurants;
}

# pragma mark - methods for view controlling

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // put this in the other screen so it loads earlier...
    self.listOfRestaurants = [self.nearbyRestaurants getRestaurantsAt:self.currLocation];
    // 
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.listOfRestaurants count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"RestaurantCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSDictionary *restaurantInfo = [self.listOfRestaurants objectAtIndex:indexPath.row];
    cell.textLabel.text = [restaurantInfo objectForKey:@"name"];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [segue.destinationViewController setRestaurantInfo:self.selectedRestaurant];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedRestaurant = [self.listOfRestaurants objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showMenu" sender:self];
}

@end


