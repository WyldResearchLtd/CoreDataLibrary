//
//  WRService.m
//  Pods
//
//  Created by Gene Myers on 21/08/2016.
//
//

#import "WRService.h"
#import "TestEntity.h"


@implementation WRService

- (id)init {
    self = [super init];
    if (self) {

        NSManagedObjectContext* localContext = [self setupCoreData];
        
        //service
        [self persistNewEntity:@"Test" withContext:localContext];
        
        //service
        NSArray * entities = [self fetchEntities];
        
        NSLog(@"Number of entities %lu", [entities count]);
    }
    return self;
}

- (void)dealloc
{
    [MagicalRecord cleanUp];
    //http://stackoverflow.com/questions/7292119/custom-dealloc-and-arc-objective-c
    //[super dealloc];//provided by the compiler
}

-(NSManagedObjectContext*) setupCoreData {
    
    //must NOT do this if we do the manual way below
    //[MagicalRecord setupCoreDataStack];
    
    NSURL *modelURL = [[NSBundle bundleForClass:[WRService class]] URLForResource:@"Model" withExtension:@"momd"];
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    [MagicalRecord setShouldAutoCreateManagedObjectModel:NO];
    [NSManagedObjectModel setDefaultManagedObjectModel:mom];
    
    //must NOT use MR_urlForStoreName
    //NSURL *storeURL = [NSPersistentStore MR_urlForStoreName:[@"Model" stringByAppendingString:@".sqlite"]];
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSURL* storeURL = [NSURL fileURLWithPath:[documentsDirectory stringByAppendingString:@"/Model.sqlite"] isDirectory:NO];
    
    
    NSPersistentStoreCoordinator * coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    NSDictionary *pragmaOptions = [NSDictionary dictionaryWithObject:@"WAL" forKey:@"journal_mode"];
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:NO], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:NO], NSInferMappingModelAutomaticallyOption,
                             pragmaOptions, NSSQLitePragmasOption,
                             nil];
    
    NSError * error= nil;
    
    NSPersistentStore * metroStore =[coordinator
                                     addPersistentStoreWithType:NSSQLiteStoreType
                                     configuration:@"Model"
                                     URL:storeURL
                                     options:options
                                     error:&error];
    if (!metroStore || error)
    {
        NSLog(@"Error setting up store:%@ for %@", [error localizedDescription], storeURL);
        exit(-1);
    }
    
    [NSPersistentStoreCoordinator MR_setDefaultStoreCoordinator:coordinator];
    
    [NSManagedObjectContext MR_initializeDefaultContextWithCoordinator:coordinator];
    
    NSManagedObjectContext *localContext = [NSManagedObjectContext MR_contextForCurrentThread];
    
    return localContext;
    
}


- (void)persistNewEntity:(NSString *)value withContext:(NSManagedObjectContext*) context {

        // Create a new Person in the current thread context
    TestEntity *te   = [TestEntity MR_createEntity];//]InContext:context];
        te.testattribute = value;
        
        // Save the modification in the local context
        // With MagicalRecords 2.0.8 or newer you should use the MR_saveNestedContexts
        [context MR_saveToPersistentStoreAndWait];
}

-(NSArray*) fetchEntities {
    // Query to find all the persons store into the database
    return [TestEntity MR_findAll];
}

@end
