//
//  WRViewController.h
//  CoreDataLibrary
//
//  Created by Gene Myers on 08/21/2016.
//  Copyright (c) 2016 Gene Myers. All rights reserved.
//

@import UIKit;
#define MR_SHORTHAND
#import "CoreData+MagicalRecord.h"
#import "HostEntity.h"
#import "WRService.h"

@interface WRViewController : UIViewController
-(NSManagedObjectContext*) setupCoreData;
@end
