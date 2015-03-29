//
//  DAL+Universal.h
//
//  Copyright (c) 2014 Angus Tasker. All rights reserved.
//

#import "DAL.h"

extern NSString * const ENTITY_NAME;

@interface DAL (Universal)

-(id)fetchRecordForEntity:(NSString*)entityName forID:(NSString *)ID;

//method to insert the new entity
-(id)insertNewEntity:(NSDictionary*)attributeDictionary;

@end
