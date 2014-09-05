//
//  cfKPISceneViewController.h
//  DiabetesCare
//
//  Created by Chen, Fan on 7/16/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapkuLibrary/TapkuLibrary.h"
#import <CoreData/CoreData.h>

@class CFBloodPressureViewController;

@protocol CFBloodPressureViewControllerDelegate <NSObject>
- (void)PressureDidBack:(CFBloodPressureViewController *)controller;
@end

@interface CFBloodPressureViewController : UIViewController<NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate, TKCalendarDayViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@property (weak, nonatomic) IBOutlet UITableView *myDetailTableView;

@property (strong, nonatomic) NSDate *workingDate;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, weak) id <CFBloodPressureViewControllerDelegate> delegate;


@end
