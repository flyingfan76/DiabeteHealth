//
//  CFSettingsViewController.m
//  DiabetesCare
//
//  Created by Chen, Fan on 9/23/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import "CFSettingsViewController.h"

#import "CustomViewCell.h"

#import <MessageUI/MessageUI.h>

#ifdef USES_IASK_STATIC_LIBRARY
#import "InAppSettingsKit/IASKSettingsReader.h"
#else
#import "IASKSettingsReader.h"
#endif


@interface CFSettingsViewController ()

@end

@implementation CFSettingsViewController

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
    // Do any additional setup after loading the view.
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

#pragma mark -
#pragma mark IASKAppSettingsViewControllerDelegate protocol
- (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController*)sender {
    [self dismissModalViewControllerAnimated:YES];
	
	// your code here to reconfigure the app for changed settings
}

// optional delegate method for handling mail sending result
- (void)settingsViewController:(id<IASKViewController>)settingsViewController mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    if ( error != nil ) {
        // handle error here
    }
    
    if ( result == MFMailComposeResultSent ) {
        // your code here to handle this result
    }
    else if ( result == MFMailComposeResultCancelled ) {
        // ...
    }
    else if ( result == MFMailComposeResultSaved ) {
        // ...
    }
    else if ( result == MFMailComposeResultFailed ) {
        // ...
    }
}
- (CGFloat)settingsViewController:(id<IASKViewController>)settingsViewController
                        tableView:(UITableView *)tableView
        heightForHeaderForSection:(NSInteger)section {
    NSString* key = [settingsViewController.settingsReader keyForSection:section];
	if ([key isEqualToString:@"IASKLogo"]) {
		return [UIImage imageNamed:@"Icon.png"].size.height + 25;
	} else if ([key isEqualToString:@"IASKCustomHeaderStyle"]) {
		return 55.f;
    }
	return 0;
}

- (UIView *)settingsViewController:(id<IASKViewController>)settingsViewController
                         tableView:(UITableView *)tableView
           viewForHeaderForSection:(NSInteger)section {
    NSString* key = [settingsViewController.settingsReader keyForSection:section];
	if ([key isEqualToString:@"IASKLogo"]) {
		UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon.png"]];
		imageView.contentMode = UIViewContentModeCenter;
		return imageView;
	} else if ([key isEqualToString:@"IASKCustomHeaderStyle"]) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor redColor];
        label.shadowColor = [UIColor whiteColor];
        label.shadowOffset = CGSizeMake(0, 1);
        label.numberOfLines = 0;
        label.font = [UIFont boldSystemFontOfSize:16.f];
        
        //figure out the title from settingsbundle
        label.text = [settingsViewController.settingsReader titleForSection:section];
        
        return label;
    }
	return nil;
}

- (CGFloat)tableView:(UITableView*)tableView heightForSpecifier:(IASKSpecifier*)specifier {
	if ([specifier.key isEqualToString:@"customCell"]) {
		return 44*3;
	}
	return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForSpecifier:(IASKSpecifier*)specifier {
	CustomViewCell *cell = (CustomViewCell*)[self.tableView dequeueReusableCellWithIdentifier:specifier.key];
	
	if (!cell) {
        
        cell = (CustomViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"CustomViewCell"
															   owner:self
															 options:nil] objectAtIndex:0];
	}
	//cell.textView.text= [[NSUserDefaults standardUserDefaults] objectForKey:specifier.key] != nil ?
    [[NSUserDefaults standardUserDefaults] objectForKey:specifier.key] ; //[specifier defaultStringValue];
	//cell.textView.delegate = self;
	[cell setNeedsLayout];
	return cell;
}

#pragma mark kIASKAppSettingChanged notification
- (void)settingDidChange:(NSNotification*)notification {
	if ([notification.object isEqual:@"AutoConnect"]) {
		IASKAppSettingsViewController *activeController = self.presentingViewController;
		BOOL enabled = (BOOL)[[notification.userInfo objectForKey:@"AutoConnect"] intValue];
		[activeController setHiddenKeys:enabled ? nil : [NSSet setWithObjects:@"AutoConnectLogin", @"AutoConnectPassword", nil] animated:YES];
	}
}

#pragma mark UITextViewDelegate (for CustomViewCell)
- (void)textViewDidChange:(UITextView *)textView {
    [[NSUserDefaults standardUserDefaults] setObject:textView.text forKey:@"customCell"];
    [[NSNotificationCenter defaultCenter] postNotificationName:kIASKAppSettingChanged object:@"customCell"];
}



@end
