// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to HostEntity.m instead.

#import "_HostEntity.h"

@implementation HostEntityID
@end

@implementation _HostEntity

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"HostEntity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"HostEntity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"HostEntity" inManagedObjectContext:moc_];
}

- (HostEntityID*)objectID {
	return (HostEntityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic hostattribute;

@end

@implementation HostEntityAttributes 
+ (NSString *)hostattribute {
	return @"hostattribute";
}
@end

