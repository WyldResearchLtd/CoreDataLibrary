//
//  WRService.m
//  Pods
//
//  Created by Gene Myers on 21/08/2016.
//
//

#import "WRService.h"


@implementation WRService

- (id)init {
    self = [super init];
    if (self) {
        [MagicalRecord setupCoreDataStack];
    }
    return self;
}

- (void)dealloc
{
    [MagicalRecord cleanUp];
    //http://stackoverflow.com/questions/7292119/custom-dealloc-and-arc-objective-c
    //[super dealloc];//provided by the compiler
}

@end
