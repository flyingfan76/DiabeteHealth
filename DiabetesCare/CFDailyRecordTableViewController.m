//
//  cfDiabetesTodayTableViewController.m
//  DiabetesCare
//
//  Created by Chen, Fan on 7/15/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import "CFDailyRecordTableViewController.h"
#import "ProfileMasterData.h"
#import "cfAppDelegate.h"
#import "HistoryRecords.h"

#import "TapkuLibrary/TapkuLibrary.h"

#import "CFKPIViewController.h"
#import "CFBloodPressureViewController.h"




@interface CFDailyRecordTableViewController () <TKCalendarMonthViewDelegate>

- (double) calculateBMI;
// @property (weak, nonatomic) TKCalendarMonthView *myCalendarView;

@end

@implementation CFDailyRecordTableViewController{


}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (!self.workingDate){
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        
        NSDate *date = [NSDate date];
        NSDateComponents *comps = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                         fromDate:date];
        
        
        self.workingDate = [cal dateFromComponents:comps]; //This variable should now be pointing at
    }
    

    
    TKCalendarMonthView *myCalendarView = [[TKCalendarMonthView alloc] initWithFrame:CGRectMake(0, 64, 320, 120)];
    [myCalendarView selectDate:self.workingDate];
    myCalendarView.delegate = self;
    myCalendarView.backgroundColor = [UIColor colorWithRed:(160/255.0) green:(97/255.0) blue:(5/255.0) alpha:1] ;
    self.tableView.tableHeaderView = myCalendarView;


    //self.tableView.tableHeaderView = myCalendarView;
//    NSLog(@"table header view=%@",self.tableView.tableHeaderView);
    
    self.glycemiaAfterFood.text = NSLocalizedString(@"glycemiaAfterFood", nil);
    self.glycemiaBeforeFood.text = NSLocalizedString(@"glycemiaBeforeFood",nil);
    self.bloodPressure.text = NSLocalizedString(@"bloodPressure",nil);
    
    self.bmiSlider.maximumValue = 30.0f;
    self.bmiSlider.minimumValue = 0.0f;
    
    int value = [self calculateBMI];
    if (value  > 30){
        self.bmiSlider.value = 30;
    }else{
        self.bmiSlider.value = value;
    }
    
    self.bmiLabel.text = [[NSNumber numberWithFloat:self.bmiSlider.value] stringValue];

   
    [self updateStaticContent];
    
    self.bannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, 320, 50)];
    [self.bannerView setDelegate:self];
    [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
    
    // Assumes the banner view is just off the bottom of the screen.
    self.bannerView.frame = CGRectOffset(self.bannerView.frame, 0, -self.bannerView.frame.size.height);
    
    [UIView commitAnimations];
    
    [self setupAppearance];
    
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

#pragma mark header


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    if(section == 0) {
//        return tableView.tableHeaderView;
//    } else {
//        return nil;
//    }
//    
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if(section == 0)
//        return tableView.tableHeaderView.frame.size.height;
//    else
//        return 30;
//}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (double) calculateBMI{

   // ProfileMasterData* myUser = [(cfAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];//Code for getting current user
    
    NSNumber *bmi = [[NSNumber alloc] initWithDouble:30];
    
    NSString *weightStr = [[NSUserDefaults standardUserDefaults] stringForKey:@"weight_preference"];
    NSString *heightStr =  [[NSUserDefaults standardUserDefaults] stringForKey:@"height_preference"];
    
    double weight = [weightStr doubleValue];
    double height = [heightStr doubleValue]/100;
    
    if (height != 0)
    {
        //bmi = @([myUser.height doubleValue]/[myUser.weight doubleValue]);
        bmi = @(weight/(height*height));
    }
    
    return [bmi doubleValue];
}


#pragma mark - Table view data source



#pragma mark - fetchResultsController


-(NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequestItems = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *globalcontext =  [(cfAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    ProfileMasterData* myUser = [(cfAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];//Code for getting current user
    //NSManagedObjectContext *globalcontext = myUser.managedObjectContext;
    NSEntityDescription *entityItem = [NSEntityDescription entityForName:@"HistoryRecords" inManagedObjectContext:globalcontext];
    [fetchRequestItems setEntity:entityItem];
    
    if (! self.workingDate){
        NSDate *now = [NSDate date];
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *components = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:now];
        
        self.workingDate = [cal dateFromComponents:components]; //This variable should now be pointing at
    }
    
    
    //out of data store based on some paramator
    [fetchRequestItems setPredicate:[NSPredicate predicateWithFormat:@"toMaster == %@ and date == %@",myUser,self.workingDate]];
    
    //Sort by last edit ordered
    NSSortDescriptor *sortType = [[NSSortDescriptor alloc] initWithKey:@"type" ascending:YES];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortType,sort,nil];
    [fetchRequestItems setSortDescriptors:sortDescriptors];
    
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:fetchRequestItems managedObjectContext:globalcontext
                                                             sectionNameKeyPath:@"type" cacheName:nil];
    
    self.fetchedResultsController = aFetchedResultsController;
	NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
	    NSLog(@"Core data error %@, %@", error, [error userInfo]);
	    abort();
	}
    //_fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

- (void) updateStaticContent{
    
    
    self.avgBloodPressure.text = @"0";
    self.avgGlycemiaAfterFood.text = @"0";
    self.avgGlycemiaBeforeFood.text = @"0";
    
    
    NSArray *sections = [self.fetchedResultsController sections];
    if (sections){
        for (int i=0; i< [sections count];i++){
            id sectionInfo = [sections objectAtIndex:i];
            
            if (sectionInfo){
                for (int j=0; j<[sectionInfo numberOfObjects];j++){
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                    HistoryRecords *o = [self.fetchedResultsController objectAtIndexPath:indexPath];
                    
                    switch ([o.type intValue] ){
                        case 0: // blood suger before food
                            self.avgGlycemiaBeforeFood.text = [o.value stringValue];
                            break;
                        case 1:
                            self.avgGlycemiaAfterFood.text = [o.value stringValue];
                            break;
                        case 2:
                            self.avgBloodPressure.text = [o.value stringValue];
                            break;
                        others:
                            NSLog(@"should be something wrong here");
                            break;
                    }
 
                }
            }
        }
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"segue identififer = %@",segue.identifier);
    
    if( [[segue identifier] isEqualToString:@"bmiSegue"]){
        //CFDailyRecordTableViewController *destinationController = [segue destinationViewController];
    }else if ([[segue identifier] isEqualToString:@"glycemiaSegue"]){
        CFKPIViewController *destinationController = [segue destinationViewController];
        destinationController.workingDate = self.workingDate;
        destinationController.delegate = self;
        
    }else if ([[segue identifier] isEqualToString:@"bloodPressureSegue"]){
        CFBloodPressureViewController *destinationController = [segue destinationViewController];
        destinationController.workingDate = self.workingDate;
        destinationController.delegate = self;
    }
    
    
}

#pragma mark - calerndar view

/** The highlighed date changed.
 @param monthView The calendar month view.
 @param date The highlighted date.
 */
- (void) calendarMonthView:(TKCalendarMonthView*)monthView didSelectDate:(NSDate*)date{
    if ([self.workingDate compare:date] != NSOrderedSame){
        self.workingDate = date;
        _fetchedResultsController = nil;
        [self updateStaticContent];
    }
}



- (void) updateTableOffset:(BOOL)animated calendarView:(TKCalendarMonthView*)monthView{
    
    if(animated){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.4];
        [UIView setAnimationDelay:0.1];
    }
    
    
//    [self.tableView.tableHeaderView setNeedsLayout];
//    [self.tableView.tableHeaderView layoutIfNeeded];
//    CGFloat height = [monthView  systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + monthView.frame.origin.y; // adding the origin because innerHeaderView starts partway down headerView.
//    
//    CGRect headerFrame = self.tableView.tableHeaderView.frame;
//    headerFrame.size.height = height;
    self.tableView.tableHeaderView = self.tableView.tableHeaderView;
    

    //NSLog(@"SIZE %@",self.tableView.frame);
    
    if(animated) [UIView commitAnimations];
}

/** The calendar did change the current month to grid shown.
 @param monthView The calendar month view.
 @param month The month date.
 @param animated Animation flag
 */
- (void) calendarMonthView:(TKCalendarMonthView*)monthView monthDidChange:(NSDate*)month animated:(BOOL)animated{
    [self updateTableOffset:animated calendarView:monthView];
}


- (void)DidBack:(CFKPIViewController *)controller{
    _fetchedResultsController = nil;
    [self updateStaticContent];
}

- (void)PressureDidBack:(CFBloodPressureViewController *)controller{
    _fetchedResultsController = nil;
    [self updateStaticContent];
}

-(void)setupAppearance {
    UIImage *minImage = [[UIImage imageNamed:@"slider_minimum.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    UIImage *maxImage = [[UIImage imageNamed:@"slider_maximum.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    UIImage *thumbImage = [UIImage new];
    
    [[UISlider appearance] setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    [[UISlider appearance] setMinimumTrackImage:minImage forState:UIControlStateNormal];
    [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateNormal];
}


@end
