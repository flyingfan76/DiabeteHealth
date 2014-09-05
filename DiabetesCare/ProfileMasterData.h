//
//  ProfileMasterData.h
//  DiabetesCare
//
//  Created by Chen, Fan on 8/27/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class HistoryMedicalRecord, HistoryRecords, TodayRecord;

@interface ProfileMasterData : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSNumber * isCurrent;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * sex;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSSet *toHistory;
@property (nonatomic, retain) NSSet *toToday;
@property (nonatomic, retain) NSSet *toMedicalRecord;
@end

@interface ProfileMasterData (CoreDataGeneratedAccessors)

- (void)addToHistoryObject:(HistoryRecords *)value;
- (void)removeToHistoryObject:(HistoryRecords *)value;
- (void)addToHistory:(NSSet *)values;
- (void)removeToHistory:(NSSet *)values;

- (void)addToTodayObject:(TodayRecord *)value;
- (void)removeToTodayObject:(TodayRecord *)value;
- (void)addToToday:(NSSet *)values;
- (void)removeToToday:(NSSet *)values;

- (void)addToMedicalRecordObject:(HistoryMedicalRecord *)value;
- (void)removeToMedicalRecordObject:(HistoryMedicalRecord *)value;
- (void)addToMedicalRecord:(NSSet *)values;
- (void)removeToMedicalRecord:(NSSet *)values;

@end
