//
//  DetailViewController.h
//  RetroPhoneHunter
//
//  Created by Paul Pilone on 5/5/13.
//  Copyright (c) 2013 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@class PhoneBooth;
@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate, UIActionSheetDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) PhoneBooth *detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
