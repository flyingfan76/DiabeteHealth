//
//  cfMainMenuTableViewCell.h
//  DiabetesCare
//
//  Created by Chen, Fan on 7/10/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFMenuTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *label;
@property (weak, nonatomic) IBOutlet UIImageView *imagePlaceHolder; //rename from image to imagePlaceHolder since UITableViewCell already had one property so called imageView :)

@end
