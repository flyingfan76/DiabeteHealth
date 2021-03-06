//
//  cfEditAndAddSceneController.h
//  DiabetesCare
//
//  Created by Chen, Fan on 7/31/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodayRecord.h"
#import <iAd/iAd.h>
#import "GADBannerView.h"

@interface CFBloodPressureModifyViewController : UIViewController<UITextFieldDelegate,ADBannerViewDelegate,GADBannerViewDelegate>


@property (weak, nonatomic) IBOutlet UITextField *myDateTime;
@property (weak, nonatomic) IBOutlet UITextField *myBloodPressure;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@property (strong,nonatomic) TodayRecord * currentRecord;
@property (strong,nonatomic) NSDate *workdingDate;

@property (nonatomic,retain) UIView *inputAccView;
@property (nonatomic,retain) UIDatePicker *inputView;


@property (nonatomic, strong) ADBannerView *bannerView;
@property (nonatomic, strong) GADBannerView *admobBannerView;


@end
