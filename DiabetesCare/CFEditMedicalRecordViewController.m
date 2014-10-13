//
//  CFEditMedicalRecordViewController.m
//  DiabetesCare
//
//  Created by Chen, Fan on 8/26/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import "CFEditMedicalRecordViewController.h"
#import "cfAppDelegate.h"
#import "ImageRecord.h"
#import "CFMedicalRecordCollectionViewCell.h"
#import "CFDisplaySinglePictureViewController.h"

@interface CFEditMedicalRecordViewController () <CFDisplaySinglePictureViewControllerDelegate>

@end

@implementation CFEditMedicalRecordViewController {
    int deleteImg;
    int selectedItem;

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
    selectedItem = 0;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self.myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"my_cell"];

    self.medicalTimeLabel.text = NSLocalizedString(@"Medical Date", nil);
    
    if (self.currentRecord) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd.MM.yyyy"];
        
        //Optionally for time zone converstions
        
        NSString *stringFromDate = [formatter stringFromDate:self.currentRecord.date];
        
        self.workingDate = self.currentRecord.date;
        
        [self.medicalTime setText:stringFromDate];
        
        self.images = [[NSMutableArray alloc] init];
        
        for (id item in self.currentRecord.toImage) {
            if([item isKindOfClass:[ImageRecord class]])
            {
                ImageRecord *one = item;
                UIImage *aImage = [UIImage imageWithData:one.image];
                [self.images addObject:aImage];
            }
           
        }
        
        UIImage *add = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"addPhoto" ofType:@"png"]];
        
        [self.images addObject:add];
        
    }else{
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd.MM.yyyy"];
        
        //Optionally for time zone converstions
        
         NSCalendar *cal = [NSCalendar currentCalendar];
        NSDate *date = [NSDate date];
        NSDateComponents *comps = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                         fromDate:date];
        
        
        self.workingDate = [cal dateFromComponents:comps]; //This variable should now be pointing at
        
        NSString *stringFromDate = [formatter stringFromDate:self.workingDate];
        
        self.medicalTime.text = stringFromDate;
        
        self.images = [[NSMutableArray alloc] init];
        
        UIImage *add = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"addPhoto" ofType:@"png"]];

        [self.images addObject:add];
        
    }
    
     [self.myCollectionView setBackgroundColor:[UIColor clearColor]];
    
    // attach long press gesture to collectionView
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = .5; //seconds
    lpgr.delegate = self;
    lpgr.delaysTouchesBegan = YES;
    [self.myCollectionView addGestureRecognizer:lpgr];
    
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

- (void) setupCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    
    [self.myCollectionView setPagingEnabled:YES];
    [self.myCollectionView setCollectionViewLayout:flowLayout];
    //self.myCollectionView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if( [[segue identifier] isEqualToString:@"addPhoto"]){
        CFDisplaySinglePictureViewController *destinationController = [segue destinationViewController];
        destinationController.displayMode = 0;
        destinationController.delegate = self;
    } else if ( [[segue identifier] isEqualToString:@"showPhoto"]){
        CFDisplaySinglePictureViewController *destinationController = [segue destinationViewController];
        destinationController.displayMode = 1;
        destinationController.imageTobeDisplay = [self.images objectAtIndex:selectedItem];
        destinationController.delegate = self;
    }

}



#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [self.images count];
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CFMedicalRecordCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MedicalRecordCell" forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor whiteColor];
    
    UIImage *aImage = [self.images objectAtIndex:indexPath.row];
    [cell.myImageView setImage:aImage];
    


    return cell;
}
// 4
/*- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 return [[UICollectionReusableView alloc] init];
 }*/


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //CFMedicalRecordCollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [self.medicalTime resignFirstResponder];
    
    
    if (indexPath.row + 1 == [self.images count]) {
        
        [self performSegueWithIdentifier:@"addPhoto" sender:self];
        
        [self.myCollectionView deselectItemAtIndexPath:indexPath animated:YES];
        
    }else{
        selectedItem = indexPath.row;
        [self performSegueWithIdentifier:@"showPhoto" sender:self];

        [self.myCollectionView deselectItemAtIndexPath:indexPath animated:YES];

    }
    
    

    // TODO: Select Item
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}


#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *searchTerm = self.searches[indexPath.section];
//    FlickrPhoto *photo =self.searchResults[searchTerm][indexPath.row];
    // 2
    CGSize retval = CGSizeMake(100, 100 );
    retval.height += 35;
    retval.width += 35;
    return retval;
}

// 3
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 20, 50, 20);
}

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
        [dateFormatter setDateFormat:@"dd.MM.yyyy"]; //desired format
        
        self.currentRecord.date = [dateFormatter dateFromString:self.medicalTime.text];
        
        self.currentRecord.type = [NSNumber numberWithInteger:0];  // medical record
        
        [self.currentRecord removeToImage:self.currentRecord.toImage];
        
        for(int i = 0; i< [self.images count] - 1; i++){
            ImageRecord *oneImageRecord = [NSEntityDescription insertNewObjectForEntityForName:@"ImageRecord" inManagedObjectContext:globalcontext];
            NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation([self.images objectAtIndex:i])];
            oneImageRecord.image = imageData;
            oneImageRecord.toMedical = self.currentRecord;
        }
        
        //save photos tbd
        
    } else {
        // Create a new device
        HistoryMedicalRecord *newRecord = [NSEntityDescription insertNewObjectForEntityForName:@"HistoryMedicalRecord" inManagedObjectContext:globalcontext];
        
        ProfileMasterData* myUser = [(cfAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];//Code for getting current user
        newRecord.toMaster = myUser;
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        //[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]]; //or another LocaleIdentifier instead of en_US
        [dateFormatter setDateFormat:@"dd.MM.yyyy"]; //desired format
        
        newRecord.date = [dateFormatter dateFromString:self.medicalTime.text];
        
        newRecord.type = [NSNumber numberWithInteger:0];
        
        //save photos tdd
        for(int i = 0; i< [self.images count] - 1; i++){
            ImageRecord *oneImageRecord = [NSEntityDescription insertNewObjectForEntityForName:@"ImageRecord" inManagedObjectContext:globalcontext];
            NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation([self.images objectAtIndex:i])];
            oneImageRecord.image = imageData;
            oneImageRecord.toMedical = newRecord;
        }
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
        [self.inputView setDate:self.workingDate];
        [self.inputView setDatePickerMode:UIDatePickerModeDate];
        [textField setInputView:self.inputView];
        
        [self createInputAccessoryView];
        [textField setInputAccessoryView:self.inputAccView];
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
    [self.medicalTime resignFirstResponder];
}

-(void)doneDateInput{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"]; //desired format
    
    
    
    self.medicalTime.text = [dateFormatter stringFromDate:[self.inputView date]];
    [self.medicalTime resignFirstResponder];
}



#pragma mark - for collection view
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    [self.medicalTime resignFirstResponder];
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    CGPoint p = [gestureRecognizer locationInView:self.myCollectionView];
    
    NSIndexPath *indexPath = [self.myCollectionView indexPathForItemAtPoint:p];
    if (indexPath == nil){
        NSLog(@"couldn't find index path");
    } else if ( (indexPath.row + 1) == [self.images count]){
        NSLog(@"add image and do nothing");
    } else {
        // get the cell at indexPath (the one you long pressed)
        //UICollectionViewCell* cell = [self.myCollectionView cellForItemAtIndexPath:indexPath];
        // do stuff with the cell
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"What do you want to do with the file?"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:@"Delete it"
                                                        otherButtonTitles:nil];

        [actionSheet showInView:self.view];
        
        deleteImg = indexPath.row;
        
        //[self.images removeObjectAtIndex:indexPath.row];
        //[self.myCollectionView reloadData];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"Index = %d - Title = %@", buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
    
    if (buttonIndex == 0)
    {
        [self.images removeObjectAtIndex:deleteImg];
        [self.myCollectionView reloadData];
    }
}


#pragma mark - for delegate call back 

-(void) addSinglePictureViewController:(UIImage *)image{
    int count = [self.images count];
    [self.images insertObject:image atIndex:count-1];
    [self.myCollectionView reloadData];
}



@end
