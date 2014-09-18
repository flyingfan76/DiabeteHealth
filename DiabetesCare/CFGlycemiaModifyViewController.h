//
//  cfEditAndAddSceneController.h
//  DiabetesCare
//
//  Created by Chen, Fan on 7/31/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodayRecord.h"

@interface CFGlycemiaModifyViewController : UIViewController<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *myDateTime;
@property (weak, nonatomic) IBOutlet UITextField *myGlycemia;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@property (strong,nonatomic) TodayRecord * currentRecord;
@property (strong,nonatomic) NSDate *workdingDate;

@property (nonatomic,retain) UIView *inputAccView;
@property (nonatomic,retain) UIDatePicker *inputView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *mySegmentedSelection;
@property (weak, nonatomic) IBOutlet UILabel *sampleTime;
@property (weak, nonatomic) IBOutlet UILabel *sampleValue;

@end
