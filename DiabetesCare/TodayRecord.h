//
//  TodayRecord.h
//  DiabetesCare
//
//  Created by Chen, Fan on 8/27/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProfileMasterData;

@interface TodayRecord : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSNumber * value;
@property (nonatomic, retain) ProfileMasterData *toMaster;

@end
