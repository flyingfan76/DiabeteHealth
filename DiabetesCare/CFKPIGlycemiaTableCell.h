//
//  cfKPISceneBloodSugarTableCellTableViewCell.h
//  DiabetesCare
//
//  Created by Chen, Fan on 7/24/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFKPIGlycemiaTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *myDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *myBloodSugar;

@property (weak, nonatomic) IBOutlet UIImageView *myTime;

@end
