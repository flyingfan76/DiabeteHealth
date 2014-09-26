//
//  RecipeDetailViewController.h
//  RecipeApp
//
//  Created by Simon on 23/12/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"
#import <iAd/iAd.h>
#import "GADBannerView.h"


@interface RecipeDetailViewController : UIViewController<ADBannerViewDelegate,GADBannerViewDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *recipeImageView;

@property (weak, nonatomic) IBOutlet UILabel *prepTimeLabel;
@property (weak, nonatomic) IBOutlet UITextView *ingredientsTextView;

@property (nonatomic, strong) Recipe *recipe;


@property (nonatomic, strong) ADBannerView *bannerView;
@property (nonatomic, strong) GADBannerView *admobBannerView;

@end
