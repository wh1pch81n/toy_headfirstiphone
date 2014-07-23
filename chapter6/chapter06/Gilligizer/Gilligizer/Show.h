//
//  Show.h
//  Gilligizer
//
//  Created by Derrick Ho on 7/13/14.
//  Copyright (c) 2014 Element 84, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Show : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * episodeID;
@property (nonatomic, retain) NSNumber * firstRun;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * showTime;

@end
