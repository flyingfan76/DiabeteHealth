//
//  CFMedicalRecordTableTableViewController.h
//  DiabetesCare
//
//  Created by Chen, Fan on 8/26/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <iAd/iAd.h>
#import "GADBannerView.h"



@interface CFMedicalRecordTableTableViewController : UITableViewController <NSFetchedResultsControllerDelegate,ADBannerViewDelegate,GADBannerViewDelegate>


@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;


@property (nonatomic, strong) ADBannerView *bannerView;
@property (nonatomic, strong) GADBannerView *admobBannerView;

@end
