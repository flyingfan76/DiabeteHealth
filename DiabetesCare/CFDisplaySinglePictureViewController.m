//
//  CFDisplaySinglePictureViewController.m
//  DiabetesCare
//
//  Created by Chen, Fan on 8/28/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import "CFDisplaySinglePictureViewController.h"

@interface CFDisplaySinglePictureViewController ()

@end

@implementation CFDisplaySinglePictureViewController{
    bool dirty;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dirty = false;
    // Do any additional setup after loading the view.
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",nil)
                                                              message:NSLocalizedString(@"Device has no camera",nil)
                                                             delegate:nil
                                                    cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    
    self.saveBtn.enabled = false;
    
    [self.takePhoto setTitle:NSLocalizedString(@"Take Photo",nil) forState:UIControlStateNormal];
    [self.choseBtn setTitle:NSLocalizedString(@"Select Photo", nil) forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
  }

- (IBAction)save:(id)sender {
    if ( self.imageView.image ){
        UIImage *add = self.imageView.image;
        [self.delegate addSinglePictureViewController:add];
    }

    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    if ( chosenImage ){
        self.imageView.image = chosenImage;
        dirty = true;
        self.saveBtn.enabled = true;
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)selectPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)takePhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}
@end
