//
//  cfBMISenceViewController.h
//  DiabetesCare
//
//  Created by Chen, Fan on 7/16/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "GADBannerView.h"

@interface CFBMIViewController : UIViewController<ADBannerViewDelegate,GADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@property (nonatomic, strong) ADBannerView *bannerView;
@property (nonatomic, strong) GADBannerView *admobBannerView;

@end
