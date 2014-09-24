//
//  cfBMISenceViewController.h
//  DiabetesCare
//
//  Created by Chen, Fan on 7/16/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface CFBMIViewController : UIViewController<ADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@end
