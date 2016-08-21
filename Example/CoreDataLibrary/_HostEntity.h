// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to HostEntity.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface HostEntityID : NSManagedObjectID {}
@end

@interface _HostEntity : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) HostEntityID *objectID;

@property (nonatomic, strong, nullable) NSString* hostattribute;

@end

@interface _HostEntity (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveHostattribute;
- (void)setPrimitiveHostattribute:(NSString*)value;

@end

@interface HostEntityAttributes: NSObject 
+ (NSString *)hostattribute;
@end

NS_ASSUME_NONNULL_END
