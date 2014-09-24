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

@interface cfHistoryViewController : UIViewController<UIWebViewDelegate,ADBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedPreSugarResultsController;
@property (strong, nonatomic) NSFetchedResultsController *fetchedAfterSugarResultsController;
@property (strong, nonatomic) NSFetchedResultsController *fetchedPressureResultsController;

@end
