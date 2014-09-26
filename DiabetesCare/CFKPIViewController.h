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
#import <iAd/iAd.h>
#import "GADBannerView.h"


@class CFKPIViewController;

@protocol CFKPIViewControllerDelegate <NSObject>
- (void)DidBack:(CFKPIViewController *)controller;
@end

@interface CFKPIViewController : UIViewController<NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate, TKCalendarDayViewDelegate,ADBannerViewDelegate,GADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@property (weak, nonatomic) IBOutlet UITableView *myDetailTableView;

@property (strong, nonatomic) NSDate *workingDate;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, weak) id <CFKPIViewControllerDelegate> delegate;

//@property (weak, nonatomic) IBOutlet UIDatePicker *myDatePicker;

@property (nonatomic, strong) ADBannerView *bannerView;
@property (nonatomic, strong) GADBannerView *admobBannerView;



@end
