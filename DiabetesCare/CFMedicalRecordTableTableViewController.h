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



@interface CFMedicalRecordTableTableViewController : UITableViewController <NSFetchedResultsControllerDelegate,ADBannerViewDelegate>


@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
