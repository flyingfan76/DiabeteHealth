//
//  CFDisplaySinglePictureViewController.h
//  DiabetesCare
//
//  Created by Chen, Fan on 8/28/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CFDisplaySinglePictureViewController;

@protocol  CFDisplaySinglePictureViewControllerDelegate <NSObject>
- (void) addSinglePictureViewController:(UIImage *)image;
@end

@interface CFDisplaySinglePictureViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> 
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBtn;

- (IBAction)selectPhoto:(id)sender;

- (IBAction)takePhoto:(id)sender;
@property (nonatomic,weak) id<CFDisplaySinglePictureViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *choseBtn;
@property (weak, nonatomic) IBOutlet UIButton *takePhoto;

@property int displayMode;
@property (weak,nonatomic) UIImage *imageTobeDisplay;

@end
