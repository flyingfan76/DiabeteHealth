//
//  cfEditAndAddSceneController.m
//  DiabetesCare
//
//  Created by Chen, Fan on 7/31/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import "CFGlycemiaModifyViewController.h"
#import "cfAppDelegate.h"

@interface CFGlycemiaModifyViewController ()

@end

@implementation CFGlycemiaModifyViewController{

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
    // Do any additional setup after loading the view.
    
    self.mySegmentedSelection.selectedSegmentIndex = 0;
    [self.mySegmentedSelection setTitle:NSLocalizedString(@"Before Food",nil) forSegmentAtIndex:0];
    [self.mySegmentedSelection setTitle:NSLocalizedString(@"After Food",nil) forSegmentAtIndex:1];
    self.sampleTime.text = NSLocalizedString(@"Sample Time", nil);
    self.sampleValue.text = NSLocalizedString(@"Sample Value", nil);
    
    
    if (self.currentRecord) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd.MM.yyyy HH:mm:ss"];
        
        //Optionally for time zone converstions
        
        NSString *stringFromDate = [formatter stringFromDate:self.currentRecord.date];
        
        [self.myDateTime setText:stringFromDate];
        
        
        [self.myGlycemia setText:[self.currentRecord.value stringValue]];
        
        self.mySegmentedSelection.selectedSegmentIndex = [self.currentRecord.type integerValue];
        
        
    }else{
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd.MM.yyyy HH:mm:ss"];
        
        //Optionally for time zone converstions
        
        NSString *stringFromDate = [formatter stringFromDate:self.workdingDate];
        
        self.myDateTime.text = stringFromDate;
        self.myGlycemia.text = @"100";
        
    }
    
    self.myGlycemia.delegate = self;
    
    self.bannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, 320, 50)];
    [self.bannerView setDelegate:self];
    [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
    
    // Assumes the banner view is just off the bottom of the screen.
    self.bannerView.frame = CGRectOffset(self.bannerView.frame, 0, -self.bannerView.frame.size.height);
    
    [UIView commitAnimations];
    
    [self.view addSubview:self.bannerView];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

}





- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Failed to retrieve ad");
    
    [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
    
    // Assumes the banner view is placed at the bottom of the screen.
    self.bannerView.frame = CGRectOffset(self.bannerView.frame, 0, self.bannerView.frame.size.height);
    
    [UIView commitAnimations];
    
    
    [self.bannerView removeFromSuperview];
    
    
    
    _admobBannerView = [[GADBannerView alloc]
                        initWithFrame:CGRectMake(0.0,0.0,
                                                 GAD_SIZE_320x50.width,
                                                 GAD_SIZE_320x50.height)];
    
    // 3
    self.admobBannerView.adUnitID = @"ca-app-pub-5104806357489598/9820115066";  //to be change
    self.admobBannerView.rootViewController = self;
    self.admobBannerView.delegate = self;
    [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
    
    // Assumes the banner view is just off the bottom of the screen.
    self.admobBannerView.frame = CGRectOffset(self.admobBannerView.frame, 0, -self.admobBannerView.frame.size.height);
    
    [UIView commitAnimations];
    // 4
    [self.view addSubview:self.admobBannerView];
    [self.admobBannerView loadRequest:[GADRequest request]];

}

- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
    [self.admobBannerView removeFromSuperview];
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


#pragma mark - save and cancel

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
     NSManagedObjectContext *globalcontext =  [(cfAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];

    
    if (self.currentRecord) {
        // Update existing device
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]]; //or another LocaleIdentifier instead of en_US
        [dateFormatter setDateFormat:@"dd.MM.yyyy HH:mm:ss"]; //desired format
        
        self.currentRecord.date = [dateFormatter dateFromString:self.myDateTime.text];
        
        self.currentRecord.type = [NSNumber numberWithInteger:self.mySegmentedSelection.selectedSegmentIndex];  // blood sugar
        
        
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        self.currentRecord.value = [f numberFromString:self.myGlycemia.text];
        
    } else {
        // Create a new device
        TodayRecord *newRecord = [NSEntityDescription insertNewObjectForEntityForName:@"TodayRecord" inManagedObjectContext:globalcontext];
        
        ProfileMasterData* myUser = [(cfAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];//Code for getting current user
        newRecord.toMaster = myUser;

        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]]; //or another LocaleIdentifier instead of en_US
        [dateFormatter setDateFormat:@"dd.MM.yyyy HH:mm:ss"]; //desired format
        
        newRecord.date = [dateFormatter dateFromString:self.myDateTime.text];
        
        newRecord.type = [NSNumber numberWithInteger:self.mySegmentedSelection.selectedSegmentIndex];
        
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        newRecord.value = [f numberFromString:self.myGlycemia.text];
        
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![globalcontext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];

}


#pragma mark - tweak the input dialog

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (100 == textField.tag ) //
    {
        self.inputView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, 320, 216)];
        
        //Configure picker...
        [self.inputView setMinuteInterval:5];
        [self.inputView setDate:self.workdingDate];
        [self.inputView setDatePickerMode:UIDatePickerModeTime];
        [textField setInputView:self.inputView];
        
        [self createInputAccessoryView];
        [textField setInputAccessoryView:self.inputAccView];
        return YES;
    }
    
    if (101 == textField.tag){
        return YES;
    }
    
    return NO;
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if( 101 == textField.tag) {
        NSCharacterSet* numberCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        for (int i = 0; i < [string length]; ++i)
        {
            unichar c = [string characterAtIndex:i];
            if (![numberCharSet characterIsMember:c])
            {
                return NO;
            }
        }
        
        return YES;
        
    }
    
    return NO;
}


-(void)createInputAccessoryView{
    // Create the view that will play the part of the input accessory view.
    // Note that the frame width (third value in the CGRectMake method)
    // should change accordingly in landscape orientation. But we don’t care
    // about that now.
    self.inputAccView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 310.0, 40.0)];
    
    // Set the view’s background color. We’ ll set it here to gray. Use any color you want.
    [self.inputAccView setBackgroundColor:[UIColor lightGrayColor]];
    
    // We can play a little with transparency as well using the Alpha property. Normally
    // you can leave it unchanged.
    [self.inputAccView setAlpha: 0.8];
    
    // If you want you may set or change more properties (ex. Font, background image,e.t.c.).
    // For now, what we’ ve already done is just enough.
    
    // Let’s create our buttons now. First the previous button.
    UIButton *btnPrev = [UIButton buttonWithType: UIButtonTypeCustom];
    
    // Set the button’ s frame. We will set their widths to 80px and height to 40px.
    [btnPrev setFrame: CGRectMake(0.0, 0.0, 80.0, 40.0)];
    // Title.
    [btnPrev setTitle: @"Cancel" forState: UIControlStateNormal];
    // Background color.
    [btnPrev setBackgroundColor: [UIColor blueColor]];
    
    // You can set more properties if you need to.
    // With the following command we’ ll make the button to react in finger tapping. Note that the
    // gotoPrevTextfield method that is referred to the @selector is not yet created. We’ ll create it
    // (as well as the methods for the rest of our buttons) later.
    [btnPrev addTarget: self action: @selector(cancelDateInput) forControlEvents: UIControlEventTouchUpInside];
    
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDone setFrame:CGRectMake(240.0, 0.0f, 80.0f, 40.0f)];
    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
    [btnDone setBackgroundColor:[UIColor greenColor]];
    [btnDone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(doneDateInput) forControlEvents:UIControlEventTouchUpInside];
    
    // Now that our buttons are ready we just have to add them to our view.
    [self.inputAccView addSubview:btnPrev];
    [self.inputAccView addSubview:btnDone];
}

-(void)cancelDateInput{
    [self.myDateTime resignFirstResponder];
}

-(void)doneDateInput{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]]; //or another LocaleIdentifier instead of en_US
    [dateFormatter setDateFormat:@"dd.MM.yyyy HH:mm:ss"]; //desired format
    
    
    
    self.myDateTime.text = [dateFormatter stringFromDate:[self.inputView date]];
    [self.myDateTime resignFirstResponder];
}


#pragma mark - segment control


@end
