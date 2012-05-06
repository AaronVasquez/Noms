//
//  NOMAddNomViewController.m
//  Noms
//
//  Created by Aaron Vasquez on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NOMAddNomViewController.h"
#import "AFJSONRequestOperation.h"
#import "AFImageRequestOperation.h"
#import "NOMNommedFoodModel.h"

@interface NOMAddNomViewController () < UIImagePickerControllerDelegate, UINavigationControllerDelegate >
@property (strong, nonatomic) NOMNommedFoodModel *nommedFood;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIImageView *foodPreview;
@property (weak, nonatomic) IBOutlet UITextField *nommentTextField;
@property (strong, nonatomic, readwrite) UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) NSString *nomment;
@property (strong, nonatomic) UIImage *image;
- (IBAction)addedNommentary:(UITextField *)sender;
- (IBAction)submitToServer:(UIButton *)sender;
- (IBAction)tapBackground:(UIView *)sender;

@end

@implementation NOMAddNomViewController
@synthesize restaurant = _restaurant;
@synthesize dish = _dish;
@synthesize nommedFood = _nommedFood;
@synthesize navigationBar = _navigationBar;
@synthesize foodPreview = _foodPreview;
@synthesize nommentTextField = _nommentTextField;
@synthesize activityIndicatorView = _activityIndicatorView;
@synthesize nomment = _nomment;
@synthesize image = _image;

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
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.activityIndicatorView.hidesWhenStopped = YES;
    //self.nommedFood = [[NOMNommedFoodModel alloc] initWith:self.dish];
	self.navigationBar.topItem.title = [self.dish objectForKey:@"name"];
}

- (void)viewDidUnload
{
    self.activityIndicatorView = nil;
    [self setNavigationBar:nil];
    [self setFoodPreview:nil];
    [self setNommentTextField:nil];
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
        // choose from library or camera
        sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = sourceType;
    imagePickerController.allowsEditing = YES; // use aviary later?
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // save locally
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil); // make async
    self.image = image;
    self.foodPreview.image = self.image; // show preview
                                    //self.nommedFood.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

#pragma mark - Actions

- (IBAction)dismissView:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)addPhoto:(id)sender {
    [self takePhoto];
}

- (IBAction)addedNommentary:(UITextField *)sender {
    [sender resignFirstResponder];
    self.nomment = sender.text;
}

- (IBAction)submitToServer:(UIButton *)sender {
 
    [self.activityIndicatorView startAnimating];
    // check for properties
    if (!self.nomment) {
        self.nomment = @"NOM NOM NOM";
        NSLog(@"%@", self.nomment);
    }
    [NOMNommedFoodModel uploadNomWithImage:self.image comment:self.nomment block:^(NOMNommedFoodModel *food, NSError *error) {
        [self.activityIndicatorView stopAnimating];
        
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Upload Failed", nil) message:[error localizedFailureReason] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil] show];
        } else {
            // show the resulting detail view
        }
    }];
    
}

- (IBAction)tapBackground:(UIView *)sender {
    [self.nommentTextField resignFirstResponder];
}
@end
