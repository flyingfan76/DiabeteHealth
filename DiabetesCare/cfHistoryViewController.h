//
//  cfHistoryViewController.h
//  DiabetesCare
//
//  Created by Chen, Fan on 8/1/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <iAd/iAd.h>
#import "GADBannerView.h"

#import "GraphDataObject.h"
#import "GraphView.h"
#import "MBProgressHUD.h"

@interface cfHistoryViewController : UIViewController<UIWebViewDelegate,ADBannerViewDelegate,GADBannerViewDelegate,GraphViewDelegate>
//@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedPreSugarResultsController;
@property (strong, nonatomic) NSFetchedResultsController *fetchedAfterSugarResultsController;
@property (strong, nonatomic) NSFetchedResultsController *fetchedPressureResultsController;

@property (nonatomic, strong) ADBannerView *bannerView;
@property (nonatomic, strong) GADBannerView *admobBannerView;

@property (nonatomic, strong) GraphView *graphView;
@property (nonatomic, strong) MBProgressHUD *hud;

@end
