//
//  DetailViewController.h
//  Gilligizer
//
//  Created by Paul Pilone on 4/22/13.
//  Copyright (c) 2013 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Show;
@interface DetailViewController : UITableViewController < UITextViewDelegate >

@property (strong, nonatomic) Show *detailItem;

@end
