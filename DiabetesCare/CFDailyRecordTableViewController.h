//
//  cfDiabetesTodayTableViewController.h
//  DiabetesCare
//
//  Created by Chen, Fan on 7/15/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapkuLibrary/TapkuLibrary.h"
#import <CoreData/CoreData.h>
#import "CFKPIViewController.h"
#import "CFBloodPressureViewController.h"


@interface CFDailyRecordTableViewController : UITableViewController <TKCalendarMonthViewDelegate,CFKPIViewControllerDelegate,CFBloodPressureViewControllerDelegate>



@property (weak, nonatomic) IBOutlet UISlider *bmiSlider;

@property (strong, nonatomic) NSDate *workingDate;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UILabel *avgGlycemiaBeforeFood;
@property (weak, nonatomic) IBOutlet UILabel *avgGlycemiaAfterFood;
@property (weak, nonatomic) IBOutlet UILabel *avgBloodPressure;
@property (weak, nonatomic) IBOutlet UILabel *glycemiaBeforeFood;
@property (weak, nonatomic) IBOutlet UILabel *glycemiaAfterFood;
@property (weak, nonatomic) IBOutlet UILabel *bloodPressure;
@property (weak, nonatomic) IBOutlet UILabel *bmiLabel;


@end
