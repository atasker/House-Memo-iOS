//
//  Picture.h
//  NextStep
//
//  Created by Habib on 3/31/14.
//  Copyright (c) 2014 Angus Tasker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Notes;

@interface Picture : NSManagedObject

@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * img_id;
@property (nonatomic, retain) Notes *note;

@end
