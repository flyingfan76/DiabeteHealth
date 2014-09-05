//
//  ImageRecord.h
//  DiabetesCare
//
//  Created by Chen, Fan on 8/27/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class HistoryMedicalRecord;

@interface ImageRecord : NSManagedObject

@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) HistoryMedicalRecord *toMedical;

@end
