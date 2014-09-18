//
//  cfKPISceneBloodSugarTableCellTableViewCell.h
//  DiabetesCare
//
//  Created by Chen, Fan on 7/24/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFBloodPressureTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *myDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *myBloodPressure;
@property (weak, nonatomic) IBOutlet UILabel *sampleTime;
@property (weak, nonatomic) IBOutlet UILabel *sampleValue;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
