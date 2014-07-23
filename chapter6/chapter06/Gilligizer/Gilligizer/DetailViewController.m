//
//  DetailViewController.m
//  Gilligizer
//
//  Created by Paul Pilone on 4/22/13.
//  Copyright (c) 2013 Element 84, LLC. All rights reserved.
//

#import "DetailViewController.h"
#import "Show.h"

@interface DetailViewController ()
- (void)configureView;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *episodeIDField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *firstRunSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *showTimeLabel;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(Show *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        [self.titleField setText:self.detailItem.title];
        [self.episodeIDField setText:[NSString stringWithFormat:@"%d", self.detailItem.episodeID.integerValue]];
        [self.descriptionView setText:self.detailItem.desc];
        [self.firstRunSegmentedControl setSelectedSegmentIndex:self.detailItem.firstRun.boolValue];
        [self.showTimeLabel setText:self.detailItem.showTime.description];
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

#pragma mark - Editing

- (IBAction)textFieldEditingChanged:(id)sender
{
    if ([sender isEqual:self.titleField]) {
        [self.detailItem setTitle:self.titleField.text];
    }
    else {
        [self.detailItem setEpisodeID:@(self.episodeIDField.text.integerValue)];
    }
}

- (IBAction)newEpisodeValueChanged:(id)sender
{
    [self.detailItem setFirstRun:@(self.firstRunSegmentedControl.selectedSegmentIndex)];
}

#pragma mark - UITextFieldDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    [self.detailItem setDesc:textView.text];
}

@end
