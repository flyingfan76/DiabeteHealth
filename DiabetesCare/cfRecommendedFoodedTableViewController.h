//
//  cfRecommendedFoodedTableViewController.h
//  DiabetesCare
//
//  Created by Chen, Fan on 8/6/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "GADBannerView.h"


@interface cfRecommendedFoodedTableViewController : UITableViewController<ADBannerViewDelegate,GADBannerViewDelegate>


@property (nonatomic, strong) ADBannerView *bannerView;
@property (nonatomic, strong) GADBannerView *admobBannerView;

@end
