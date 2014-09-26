//
//  cfViewController.h
//  DiabetesCare
//
//  Created by Chen, Fan on 7/8/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

#import <iAd/iAd.h>
#import "GADBannerView.h"

@interface CFRootViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,ADBannerViewDelegate,GADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;


@property (nonatomic, strong) ADBannerView *bannerView;
@property (nonatomic, strong) GADBannerView *admobBannerView;

@end
