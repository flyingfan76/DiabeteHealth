//
//  CFEditMedicalRecordViewController.h
//  DiabetesCare
//
//  Created by Chen, Fan on 8/26/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryMedicalRecord.h"

@interface CFEditMedicalRecordViewController : UIViewController<UITextFieldDelegate,UIGestureRecognizerDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UITextField *medicalTime;
@property (weak, nonatomic) IBOutlet UILabel *medicalTimeLabel;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@property (strong,nonatomic) HistoryMedicalRecord * currentRecord;

@property (strong,nonatomic) NSDate *workingDate;

@property (nonatomic,retain) UIView *inputAccView;
@property (nonatomic,retain) UIDatePicker *inputView;


@property (strong,nonatomic) NSMutableArray *images;

@end
