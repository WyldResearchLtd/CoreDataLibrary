# CoreDataLibrary

[![CI Status](http://img.shields.io/travis/Gene Myers/CoreDataLibrary.svg?style=flat)](https://travis-ci.org/Gene Myers/CoreDataLibrary)
[![Version](https://img.shields.io/cocoapods/v/CoreDataLibrary.svg?style=flat)](http://cocoapods.org/pods/CoreDataLibrary)
[![License](https://img.shields.io/cocoapods/l/CoreDataLibrary.svg?style=flat)](http://cocoapods.org/pods/CoreDataLibrary)
[![Platform](https://img.shields.io/cocoapods/p/CoreDataLibrary.svg?style=flat)](http://cocoapods.org/pods/CoreDataLibrary)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

CoreDataLibrary is a private CocoaPod. To install
it, simply add the following line to your Podfile:

```ruby
pod "CoreDataLibrary" , :git => 'git@github.com:WyldResearchLtd/CoreDataLibrary.git'
```

## Author

Gene Myers, gene@wyldresearch.com

## License

CoreDataLibrary is available under the MIT license. See the LICENSE file for more info.



# Creating this Example
1. From Terminal, run ```pod lib create CoreDataLibrary``` 

This is the output and input required from running the above command
```
Configuring CoreDataLibrary template.
-------------------------------------
  
To get you started we need to ask a few questions, this should only take a minute.  
  
If this is your first time we recommend running through with the guide:   
- http://guides.cocoapods.org/making/using-pod-lib-create.html  
( hold cmd and double click links to open in a browser. )  
  
  
What language do you want to use?? [ Swift / ObjC ]  
> ObjC  
  
Would you like to include a demo application with your library? [ Yes / No ]  
> Yes  
  
Which testing frameworks will you use? [ Specta / Kiwi / None ]  
> None  
  
Would you like to do view based testing? [ Yes / No ]  
> No  
  
What is your class prefix?  
> WR  
```
  
2. open the podfile and comment out ```inherit!``` line
3. Pun ```pod install``` from the Examples directory
4. From Terminal run ```open 'CoreDataLibrary/Example/CoreDataLibrary.xcworkspace'``` from the root of the SRC dir

## Adding MagicalRecord  
based on http://samwize.com/2014/03/27/step-by-step-guide-to-using-magicalrecord-and-mogenerator/  
  
1. add this to your podfile ```pod 'MagicalRecord/Shorthand', '~> 2.2'```  
2. from the Examples dfirectory, run ```pod install```  
3. Under /Pods/Development Pods/CoreDataLibrary/Classes, delete *ReplaceMe.m*  
   Right click on the Classes dir in the Project Explorer and choose Add File.  
   Select iOS->Source->CocoaTouch class- htis will create both the .m and .h file. Name the new files WRService
   The contents should be:  
  
WRService.h  
```
//
//  WRService.h
//  CoreDataLibrary Example
//
//  Created by Gene Myers on 21/08/2016.
//
//

#import <Foundation/Foundation.h>
#define MR_SHORTHAND
#import "CoreData+MagicalRecord.h"

@interface WRService : NSObject
@end
```
  
WRService.h  
```
//
//  WRService.m
//  CoreDataLibrary Pod
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
[  MagicalRecord cleanUp];
  //http://stackoverflow.com/questions/7292119/custom-dealloc-and-arc-objective-c
  //[super dealloc];//provided by the compiler
}

@end
```
  
4.  In the Project Explorer, select the Pods project, then under Build Phases->Link Binaries with Libraries,  
    Click on the + to add the MagicalRecord.framework  

5.  Select the CoreDataLibrary scheme and Run.  
6.  Select the CoreDataLibrary-Example schema, then Run  
7.  Install mogenerator with the command ```$ sudo brew install mogenerator``` 
8.  Right click on the Classes directory, select New File. Select iOS->CoreData->Data Model  
    Click 'Next', and make sure the CoreDataLibrary target is checked.  
    The Model.xcdatamodeld is placed in the Classes directory 
9.  Add a new Entity to the model (An entity is a Table)- 'TestTable'  
10. Add a new attribute to the Entity- 'testattribute' of type String  
11. With the model and TestEntity selected, in the data model inspector in the right pane, add 'TestEntity' as the Class  
12. Setup a target for mogenerator by running the following comand:  
    ```mogenerator --v2 -m "CoreDataLibrary/Classes/Model.xcdatamodeld" -O "CoreDataLibrary/Classes"```  
    If successful you will see this output:
    ```2 machine files and 2 human files generated.``` 
13. In your Pods project, open your project properties and tap the “+” button at the bottom of the Targets list.
14. Add an “Aggregate” target (you’ll find it in the iOS/Other grouping). Tap Next.
15. Name the target whatever you’d like. I’ll call mine Mogenerator. Hit Done.
16. Now select the new target you just created, select the “Build Phases” tab, tap “+” to add a build phase then select “New Run Script Build Phase”.
17. Open the Run Script group that just appeared, keep the Shell at /bin/sh, and then enter the following script if you’re using Objective-C. Because the Pods projects source directory is in the Pods directory, we have to modify the script to reference the correct directory (```mogenerator --v2 -m "../../CoreDataLibrary/Classes/Model.xcdatamodeld" -O "../../CoreDataLibrary/Classes"```)
18. Delete the files created in Step 12. Select the mogenerator target and build. This can be used regenerate all the files, if you change the model.
19. Select Pods/Development Pods/Classes dir again and right click and 'Add files to Pods', and add the 4 files.
  
  
$mogenerator --v2 -m "Example/CoreDataLibrary/Model/Host.xcdatamodeld" -O "Example/CoreDataLibrary/Model  















