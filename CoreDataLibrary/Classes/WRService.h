//
//  WRService.h
//  Pods
//
//  Created by Gene Myers on 21/08/2016.
//
//

#import <Foundation/Foundation.h>
#define MR_SHORTHAND
#import "CoreData+MagicalRecord.h"


@interface WRService : NSObject
-(NSManagedObjectContext*) setupCoreData;
-(void)persistNewEntity:(NSString *)value withContext:(NSManagedObjectContext*) context;
-(NSArray*) fetchEntities;
@end
