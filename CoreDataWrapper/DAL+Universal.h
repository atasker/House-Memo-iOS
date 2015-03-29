//
//  DAL+Universal.h
//  Club4Sms
//
//  Created by Habib Ali on 20/10/2013.
//  Copyright (c) 2013 Habib Ali. All rights reserved.
//

#import "DAL.h"

extern NSString * const ENTITY_NAME;

@interface DAL (Universal)

-(id)fetchRecordForEntity:(NSString*)entityName forID:(NSString *)ID;

//method to insert the new entity
-(id)insertNewEntity:(NSDictionary*)attributeDictionary;

@end
