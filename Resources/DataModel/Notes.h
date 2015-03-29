//
//  Notes.h
//  NextStep
//
//  Copyright (c) 2014 Angus Tasker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Picture;

@interface Notes : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * agent;
@property (nonatomic, retain) NSNumber * bathrooms;
@property (nonatomic, retain) NSNumber * bedrooms;
@property (nonatomic, retain) NSString * garden;
@property (nonatomic, retain) NSString * parking;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSNumber * squareFootage;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * starCount;
@property (nonatomic, retain) NSSet *pictures;
@end

@interface Notes (CoreDataGeneratedAccessors)

- (void)addPicturesObject:(Picture *)value;
- (void)removePicturesObject:(Picture *)value;
- (void)addPictures:(NSSet *)values;
- (void)removePictures:(NSSet *)values;

@end
