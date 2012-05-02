//
//  NOMAddNomViewController.m
//  Noms
//
//  Created by Aaron Vasquez on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NOMAddNomViewController.h"
#import "NOMNommedFoodModel.h"

@interface NOMAddNomViewController () < UIImagePickerControllerDelegate, UINavigationControllerDelegate >
@property (weak, nonatomic) NOMNommedFoodModel *nommedFood;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIImageView *foodPreview;
- (IBAction)addedNommentary:(UITextField *)sender;
- (IBAction)submitToServer:(UIButton *)sender;

@end

@implementation NOMAddNomViewController
@synthesize restaurant = _restaurant;
@synthesize dish = _dish;
@synthesize nommedFood = _nommedFood;
@synthesize navigationBar = _navigationBar;
@synthesize foodPreview = _foodPreview;

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
	self.navigationBar.topItem.title = [self.dish objectForKey:@"name"];
}

- (void)viewDidUnload
{
    [self setNavigationBar:nil];
    [self setFoodPreview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Helper Methods

- (void)takePhoto {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // choose
        sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = sourceType;
    imagePickerController.allowsEditing = YES; // use aviary later?
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - Actions

- (IBAction)dismissView:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)addPhoto:(id)sender {
    [self takePhoto];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // save to database
    UIImageWriteToSavedPhotosAlbum([info objectForKey:@"UIImagePickerControllerEditedImage"], nil, nil, nil); // make async
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (IBAction)addedNommentary:(id)sender {
}

- (IBAction)submitToServer:(UIButton *)sender {
}
@end
