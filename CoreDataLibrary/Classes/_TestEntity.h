// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestEntity.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface TestEntityID : NSManagedObjectID {}
@end

@interface _TestEntity : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TestEntityID *objectID;

@property (nonatomic, strong, nullable) NSString* testattribute;

@end

@interface _TestEntity (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveTestattribute;
- (void)setPrimitiveTestattribute:(NSString*)value;

@end

@interface TestEntityAttributes: NSObject 
+ (NSString *)testattribute;
@end

NS_ASSUME_NONNULL_END
