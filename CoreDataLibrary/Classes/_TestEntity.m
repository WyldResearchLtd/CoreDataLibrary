// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestEntity.m instead.

#import "_TestEntity.h"

@implementation TestEntityID
@end

@implementation _TestEntity

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TestEntity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TestEntity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TestEntity" inManagedObjectContext:moc_];
}

- (TestEntityID*)objectID {
	return (TestEntityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic testattribute;

@end

@implementation TestEntityAttributes 
+ (NSString *)testattribute {
	return @"testattribute";
}
@end

