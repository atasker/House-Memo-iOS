//
//  DAL+Universal.m
//  Club4Sms
//
//  Created by Habib Ali on 20/10/2013.
//  Copyright (c) 2013 Habib Ali. All rights reserved.
//

#import "DAL+Universal.h"

NSString * const ENTITY_NAME = @"EntityName";

@implementation DAL (Universal)

-(id)insertNewEntity:(NSDictionary*)attributeDictionary
{
    id obj = nil;
    NSArray *results = nil;
    NSString *validationKey = [DAL validationKeyForEntityName:[attributeDictionary valueForKey:ENTITY_NAME]];
    if (validationKey)
    {
        //create predicate dictionary with validation keys
        NSMutableDictionary * predicateDictionary = [[NSMutableDictionary alloc] init];
        
        
        [predicateDictionary setValue:[attributeDictionary objectForKey:validationKey] forKey:validationKey];
        
        
        //create the predicate
        NSPredicate *predicate = [self getPredicateWithParams:predicateDictionary withpredicateOperatorType:nil];
        
        //checking if entity already exists
        results = [self fetchRecords:[attributeDictionary valueForKey:ENTITY_NAME] withPredicate:predicate sortBy:nil assending:YES];
    }
    
    
    if (!results.count) {
        
        //insert new entity
        obj = [NSEntityDescription insertNewObjectForEntityForName:[attributeDictionary valueForKey:ENTITY_NAME] inManagedObjectContext:[self managedObjectContext]];
    }
    else
    {
        obj = [results objectAtIndex:0];
    }
    
    NSMutableArray *keys = [[attributeDictionary allKeys] mutableCopy];
    
    //remove teh key for entity name, and keep only keys for attributes
    [keys removeObject:ENTITY_NAME];
    
    //set the attributes
    for (NSString* key in keys) {
        if ([attributeDictionary valueForKey:key] && ![[attributeDictionary valueForKey:key]isKindOfClass:[NSNull class]])
            [obj setValue:[attributeDictionary valueForKey:key] forKey:key];
    }
    
    //[self saveContext];
    

    return obj;
}

-(id)fetchRecordForEntity:(NSString*)entityName forID:(NSString *)ID
{
    NSMutableDictionary * predicateDictionary = [[NSMutableDictionary alloc] init];
    
    NSString *validationKey =[DAL validationKeyForEntityName:entityName];
    
    if (validationKey)
    {
        [predicateDictionary setValue:ID forKey:validationKey];
        
        
        //create the predicate
        NSPredicate *predicate = [self getPredicateWithParams:predicateDictionary withpredicateOperatorType:nil];
        
        //checking if entity already exists
        NSArray *objects = [self fetchRecords:entityName withPredicate:predicate sortBy:nil assending:YES];
        if (objects.count!=0)
            return [objects objectAtIndex:0];
        else
            return nil;
    }
    return nil;
}

+ (NSString *)validationKeyForEntityName:(NSString *)entityname
{
    if ([entityname isEqualToString:NOTES_ENTITY_NAME])
    {
        return NOTES_TITLE;
    }
    if ([entityname isEqualToString:PICTURE_ENTITY])
    {
        return PICTURE_IMAGE_ID;
    }
    else
        return nil;
    
}



@end
