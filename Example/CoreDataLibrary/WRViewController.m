//
//  WRViewController.m
//  CoreDataLibrary
//
//  Created by Gene Myers on 08/21/2016.
//  Copyright (c) 2016 Gene Myers. All rights reserved.
//

#import "WRViewController.h"
#import "WRService.h"


@interface WRViewController ()

@end

@implementation WRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSManagedObjectContext* localContext = [self setupCoreData];
    
    //service
    [self persistNewEntity:@"Test" withContext:localContext];
    
    //service
    NSArray * entities = [self fetchEntities];
    
    NSLog(@"Number of HOST entities %lu", [entities count]);
    
     WRService * service = [[WRService alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSManagedObjectContext*) setupCoreData {
    
    //must NOT do this if we do the manual way below
    //[MagicalRecord setupCoreDataStack];
    
    NSURL *modelURL = [[NSBundle bundleForClass:[self class]] URLForResource:@"Host" withExtension:@"momd"];
   // NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    NSBundle *serviceBundle = [NSBundle bundleForClass:[WRService class]];
    
    NSArray * bundles = [NSArray arrayWithObjects:[NSBundle mainBundle], serviceBundle, nil];
    NSManagedObjectModel* mom = [NSManagedObjectModel modelByMergingModels:bundles];

    
    [MagicalRecord setShouldAutoCreateManagedObjectModel:NO];
    [NSManagedObjectModel setDefaultManagedObjectModel:mom];
    
    //must NOT use MR_urlForStoreName
    //NSURL *storeURL = [NSPersistentStore MR_urlForStoreName:[@"Model" stringByAppendingString:@".sqlite"]];
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSURL* storeURL = [NSURL fileURLWithPath:[documentsDirectory stringByAppendingString:@"/Host.sqlite"] isDirectory:NO];
    
    
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
                                     configuration:@"Host"
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
    
    /*
     
     MagicalRecord.cleanUp()
    
    let serviceBundle = NSBundle(forClass:object_getClass(WRService))
    
    let managedObjectModel = NSManagedObjectModel.mergedModelFromBundles([NSBundle.mainBundle(),serviceBundle])
    
    let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel!)
    
    //MUST NOT use MR_urlForStoreName
    //let storeURL = NSPersistentStore.MR_urlForStoreName("Wyld.LU.iOS.PoC.sqlite")
    let nsDocumentDirectory = NSSearchPathDirectory.DocumentDirectory
    let nsUserDomainMask = NSSearchPathDomainMask.UserDomainMask
    let storeFilespec = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)[0];
    let storeURL = NSURL(fileURLWithPath:storeFilespec.stringByAppendingString("/Wyld.LU.iOS.PoC.sqlite"))
    
    
    let options = [
                   NSMigratePersistentStoresAutomaticallyOption : true,
                   NSInferMappingModelAutomaticallyOption: true
                   ]
    do {
        
        try persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: "WyldPoC", URL: storeURL, options: options)
        
        NSPersistentStoreCoordinator.MR_setDefaultStoreCoordinator(persistentStoreCoordinator)
        
        NSManagedObjectContext.MR_initializeDefaultContextWithCoordinator(persistentStoreCoordinator)
        
        
        //////////////
        self.setUpInitialData()
        
    } catch {
        print("Error adding persistent store to coordinator: \(error) ")
    }

    */ 
}

- (void)persistNewEntity:(NSString *)value withContext:(NSManagedObjectContext*) context {
    
    // Create a new Person in the current thread context
    HostEntity *he   = [HostEntity MR_createEntity];//]InContext:context];
    he.hostattribute = value;
    
    // Save the modification in the local context
    // With MagicalRecords 2.0.8 or newer you should use the MR_saveNestedContexts
    [context MR_saveToPersistentStoreAndWait];
}

-(NSArray*) fetchEntities {
    // Query to find all the persons store into the database
    return [HostEntity MR_findAll];
}

@end
