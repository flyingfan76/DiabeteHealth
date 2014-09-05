//
//  HistoryMedicalRecord.h
//  DiabetesCare
//
//  Created by Chen, Fan on 8/27/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProfileMasterData;

@interface HistoryMedicalRecord : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSNumber * imageCount;
@property (nonatomic, retain) ProfileMasterData *toMaster;
@property (nonatomic, retain) NSSet *toImage;
@end

@interface HistoryMedicalRecord (CoreDataGeneratedAccessors)

- (void)addToImageObject:(NSManagedObject *)value;
- (void)removeToImageObject:(NSManagedObject *)value;
- (void)addToImage:(NSSet *)values;
- (void)removeToImage:(NSSet *)values;

@end
