//
//  CoreDataUtility.h
//  Bridges
//
//  Created by Usman Aleem on 8/2/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

//#import "NSManagedObjectContext+Copy.h"
/* 
 * Singleton Class for DataModel and CoreData operations 
 */

/**
 @brief The class encapsulate all persistence layer tasks.Singleton class
 */

extern NSString * const CD_ENTITY_NAME;


@interface DAL : NSObject {
    
    NSManagedObjectContext *managedObjectContext;
    NSManagedObjectContext *mObjectContextThread;
    //NSManagedObjectContext *managedObjectContextForInsert;
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    //NSManagedObjectContext *parentManagedObjectContext;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectContext *mObjectContextThread;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//@property (nonatomic, retain, readonly) NSManagedObjectContext *parentManagedObjectContext;

- (NSString *)applicationDocumentsDirectory;

//Shared Instance of CoreDataUtility and ManagedObjectContext
+ (DAL*)sharedInstance;
- (NSManagedObjectContext*) context;

//Save Context
- (BOOL)saveContext;

- (void)managedObjectContext:(NSManagedObjectContext**)mObjectContext;
- (void)managedObjectContextInThread:(NSManagedObjectContext**)mObjectContext;
- (BOOL)saveContext:(NSManagedObjectContext*)mObjectContext;

- (BOOL)resetDataStore;


@end