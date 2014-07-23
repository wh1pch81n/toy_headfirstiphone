//
//  DetailViewController.m
//  RetroPhoneHunter
//
//  Created by Paul Pilone on 5/5/13.
//  Copyright (c) 2013 Element 84, LLC. All rights reserved.
//

#import "DetailViewController.h"
#import "RetroPhoneHunter-Swift.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *cityField;
@property (weak, nonatomic) IBOutlet UITextView *notesView;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) UIPopoverController *imagePickerPopoverController;
@property (strong, nonatomic) CLLocationManager *locationManager;
- (void)configureView;
@end

@implementation DetailViewController {
  
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(PhoneBooth *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.nameField.text = self.detailItem.name;
        self.cityField.text = self.detailItem.city;
        self.notesView.text = self.detailItem.notes;
        self.imageView.image = [UIImage imageWithContentsOfFile:self.detailItem.imagePath];
    
        if (self.detailItem.lat != nil && self.detailItem.lon != nil) {
            self.locationLabel.text = [NSString stringWithFormat:@"Lat: %.3f, Long: %.3f", self.detailItem.lat.doubleValue, self.detailItem.lon.doubleValue];
        } else {
            self.locationLabel.text = @"No location";
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (IBAction)nameFieldEditingChanged:(id)sender {
    self.detailItem.name = self.nameField.text;
}

- (IBAction)cityFieldEditingChanged:(id)sender {
    self.detailItem.city = self.cityField.text;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.detailItem.notes = self.notesView.text;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField becomeFirstResponder];
}


#pragma mark - UIImagePickerConrollerDelegate 

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //Construct the path to the file in our Documents Directory.
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *uniqueFileName = [[NSUUID UUID] UUIDString];
    NSURL *imagePath = [[NSURL URLWithString:documentsDirectory] URLByAppendingPathComponent:uniqueFileName];
    
    //get the image from the picker and write it to disk.
    UIImage *image = info[UIImagePickerControllerEditedImage];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [UIImagePNGRepresentation(image) writeToURL:imagePath atomically:YES];
    });
    
    //save the path to the image in our model so that it can be retrieved later.
    self.detailItem.imagePath = imagePath.absoluteString;
    
    //update the image view
    self.imageView.image = image;
    
    //dismiss the picker
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.imagePickerPopoverController dismissPopoverAnimated:YES];
    self.imagePickerPopoverController = nil;
}

- (IBAction)takePictureButtonPressed:(id)sender {
    NSLog(@"Taking a picture ...");
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"This device has a camera. Asking the user what they want to use");
        
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Select PhoneBooth Picture"
                                                        delegate:self
                                               cancelButtonTitle:nil
                                          destructiveButtonTitle:nil
                                               otherButtonTitles:@"Take New Photo", @"Choose Existing Photo", nil];
        
        //show the action sheet near the add image button.
        [action showFromRect:([(UIGestureRecognizer *)sender view]).frame inView:self.view animated:YES];
    }
    else {//no camera just use the library
        UIImagePickerController *picker = [UIImagePickerController new];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        
        self.imagePickerPopoverController = [[UIPopoverController alloc] initWithContentViewController:picker];
        
        [self.imagePickerPopoverController presentPopoverFromRect:([(UITapGestureRecognizer *)sender view]).frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
       self.imagePickerPopoverController.delegate = self;
    }
}

#pragma mark - UIPopoverControllerDelegate


- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self.imagePickerPopoverController = nil;
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        NSLog(@"The user canceled adding a image");
        return;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    switch (buttonIndex) {
        case 0:
            NSLog(@"User wants to take a new picture");
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
            
        default:
            NSLog(@"user wants to from library");
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
    }
    self.imagePickerPopoverController = [[UIPopoverController alloc] initWithContentViewController:picker];
    self.imagePickerPopoverController.delegate = self;
    [self.imagePickerPopoverController presentPopoverFromRect:self.imageView.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
//    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - CORELocation

- (IBAction)locatePhoneboothButtonPressed:(id)sender {
    [self.locationManager startUpdatingLocation];
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"Core location claims to have a position");
    CLLocation *location = [locations lastObject];
    
    //update the phone booth and view
    self.detailItem.lat = @(location.coordinate.latitude);
    self.detailItem.lon = @(location.coordinate.longitude);
    
    [self configureView];
    [self.locationLabel setText:[NSString stringWithFormat:@"Lat: %.3f, Long: %.3f", location.coordinate.latitude, location.coordinate.longitude]];
    //stop monitoring locations. in a real application you would probably to keep updating
    //the location to get the most accurate position
    NSLog(@"shutting down core location");
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Core location can't get a fix");
    
    //update the view to alert the user that we can't get a location.
    self.locationLabel.text = @"Can't get a location";
}

@end
