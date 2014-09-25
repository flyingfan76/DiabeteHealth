//
//  cfKPISceneViewController.m
//  DiabetesCare
//
//  Created by Chen, Fan on 7/16/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import "CFBloodPressureViewController.h"
#import "CFBloodPressureTableCell.h"
#import "cfAjaxURLProtocol.h"
#import "cfAppDelegate.h"
#import "TodayRecord.h"
#import "CFBloodPressureModifyViewController.h"
#import "HistoryRecords.h"
#import "TapkuLibrary/TapkuLibrary.h"

@interface CFBloodPressureViewController () <TKCalendarDayViewDelegate>

@end

@implementation CFBloodPressureViewController{
    BOOL _bannerIsVisible;
    ADBannerView *_adBanner;
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
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.myDetailTableView.bounces = YES;
    self.myWebView.scrollView.scrollEnabled = NO;
    self.myWebView.scrollView.bounces = NO;
    
    

    
    //tweak the chart view
    self.myWebView.delegate = self;
    //[NSURLProtocol registerClass:[cfAjaxURLProtocol class]];
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"BloodPressurePage" ofType:@"html"];
    NSURL *instructionsURL = [NSURL fileURLWithPath:htmlFile];
	[self.myWebView loadRequest:[NSURLRequest requestWithURL:instructionsURL]];
    
    //tweak the table view
    [self inittable];
    
    if (!self.workingDate){
    
        NSCalendar *cal = [NSCalendar currentCalendar];
        
        NSDate *date = [NSDate date];
        NSDateComponents *comps = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                         fromDate:date];
        
    
        self.workingDate = [cal dateFromComponents:comps]; //This variable should now be pointing at
        
    }
    
    
    
	TKCalendarDayView *myCalendarView = [[TKCalendarDayView alloc] initWithFrame:CGRectMake(0,64,320,80)];
	myCalendarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    myCalendarView.date = self.workingDate;
    myCalendarView.delegate = self;
    //myCalendarView.delegate = self;
    [self.view addSubview:myCalendarView];
    
    
//    [self.myDatePicker addTarget:self action:@selector(oneDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged]; // 添加监听器
  
    //self.myDatePicker.maximumDate = [NSDate date];
    
    
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 381, 320, 20)];
//    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 300, 16)];
//    labelView.text = NSLocalizedString(@"Add or Modify you record",nil);
//    labelView.textAlignment = NSTextAlignmentCenter;
//    labelView.backgroundColor =  [UIColor colorWithRed:2/255.0f
//                                                 green:79.0f/255.0f
//                                                  blue:91.0f/255.0f
//                                                 alpha:1.0f];
//    [headerView addSubview:labelView];
//    self.myDetailTableView.tableHeaderView = headerView;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _adBanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, 320, 50)];
    _adBanner.delegate = self;
}


- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!_bannerIsVisible)
    {
        // If banner isn't part of view hierarchy, add it
        if (_adBanner.superview == nil)
        {
            [self.view addSubview:_adBanner];
        }
        
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        
        // Assumes the banner view is just off the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        
        [UIView commitAnimations];
        
        _bannerIsVisible = YES;
    }
}


- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Failed to retrieve ad");
    
    if (_bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        
        // Assumes the banner view is placed at the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        
        [UIView commitAnimations];
        
        _bannerIsVisible = NO;
    }
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.myDetailTableView setEditing:editing animated:YES];
    [self.myDetailTableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSArray *sections = [self.fetchedResultsController sections];
    if (sections)
    {
        return [sections count];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * sections = [self.fetchedResultsController sections];
    if (sections){
        id sectionInfo = [sections objectAtIndex:section];
        if(sectionInfo){
            return [sectionInfo numberOfObjects];
        }
    }
    return 1;
}

- (void)configureCell:(CFBloodPressureTableCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    TodayRecord *info = [_fetchedResultsController objectAtIndexPath:indexPath];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    
    cell.sampleTime.text = NSLocalizedString(@"Sample Time",nil);
    cell.sampleValue.text = NSLocalizedString(@"Sample Value",nil);
    [formatter setDateFormat:@"HH:mm:ss"];


    UIImage *newImage = [UIImage imageNamed:@"blood14.png"];
    [cell.imageView setImage:newImage];
    
    //Optionally for time zone converstions
    
    NSString *stringFromDate = [formatter stringFromDate:info.date];
    cell.myDatePicker.text = stringFromDate;
    
    
    cell.myBloodPressure.text = [info.value stringValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cfBloodPressureCell";
    
    CFBloodPressureTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CFBloodPressureTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //trigger another view
    //[self performSegueWithIdentifier:@"diabetesTodaySegue" sender:self];
    [self performSegueWithIdentifier:@"editBloodPressureSegue" sender:self];
    //tba
    
}




- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSManagedObjectContext *globalcontext =  [(cfAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [globalcontext deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        NSError *error = nil;
        if (![globalcontext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    TodayRecord *info = [_fetchedResultsController objectAtIndexPath:[self.myDetailTableView indexPathForSelectedRow]];
    
    CFBloodPressureModifyViewController *destinationController = [segue destinationViewController];
    destinationController.workdingDate = self.workingDate;
    
    if ( [[segue identifier] isEqualToString:@"editBloodPressureSegue"]){
        
        destinationController.currentRecord = info;
        
    }
}


- (void) inittable{
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]){
        NSLog(@"error happened in retrieval %@, %@", error, [error userInfo]);
        abort();
    }
}



#pragma mark - fetchResultsController


-(NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequestItems = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *globalcontext =  [(cfAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    ProfileMasterData* myUser = [(cfAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];//Code for getting current user
    //NSManagedObjectContext *globalcontext = myUser.managedObjectContext;
    NSEntityDescription *entityItem = [NSEntityDescription entityForName:@"TodayRecord"  inManagedObjectContext:globalcontext];
    [fetchRequestItems setEntity:entityItem];
    
    if (! self.workingDate){
        NSDate *now = [NSDate date];
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *components = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:now];
        
        self.workingDate = [cal dateFromComponents:components]; //This variable should now be pointing at
    }
    
    NSDateComponents* deltaComps = [[NSDateComponents alloc] init];
    [deltaComps setDay:1];
    NSDate* tomorrow = [[NSCalendar currentCalendar] dateByAddingComponents:deltaComps toDate:self.workingDate options:0];
    

    
    //out of data store based on some paramator
    [fetchRequestItems setPredicate:[NSPredicate predicateWithFormat:@"toMaster == %@ and type == 2 and date >= %@ and date < %@",myUser,self.workingDate,tomorrow]];
//    [fetchRequestItems setPredicate:[NSPredicate predicateWithFormat:@"type == 0"]];
//    [fetchRequestItems setPredicate:[NSPredicate predicateWithFormat:@"date >= %@",self.workingDate]];
    
    //Sort by last edit ordered
    NSSortDescriptor *sortType = [[NSSortDescriptor alloc] initWithKey:@"type" ascending:YES];
    NSSortDescriptor *sortDate = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortType,sortDate,nil];
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
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}



- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.myDetailTableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.myDetailTableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(CFBloodPressureTableCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.myDetailTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.myDetailTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.myDetailTableView endUpdates];
    [self updateWebView];
    [self updateHistoryView];
    
}

- (NSData *)generateFakeJson{
    //  1. option1 generate jsonData from file
    //       NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    //        NSData *jsonData = [NSData dataWithContentsOfFile:path];
    //        NSLog(@"%@",jsonData);
    
    
    //  2. option2 generate jsonData from string
    //    NSString *jsonString = @"[{\"name\":\"Before\",\"data\":[[0,10],[3600,100]]}]";
    //    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    //
    //    NSLog(@"%@",jsonData);
    
    //  3. option3 generate jsonData from NSMutableArray
    
//    NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
//    [item setObject:@"before" forKey:@"name"];
//    NSArray  *obj1 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:100],nil];
//    NSArray  *obj2 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInteger:3600],[NSNumber numberWithInteger:100],nil];
//    
//    NSMutableArray *arrayItem = [[NSMutableArray alloc] initWithObjects:obj1,obj2, nil];
//    
//    [item setObject:arrayItem forKey:@"data"];
//    
//    NSMutableArray *parent = [[NSMutableArray alloc] init];
//    [parent addObject:item];
//    
//    NSError *error = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parent options:NSJSONWritingPrettyPrinted error:&error];
//    NSLog(@"%@",jsonData);

    // 4. generate from database.
    NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
    [item setObject:@"before" forKey:@"name"];
    
    
    id  sectionInfo =[[self.fetchedResultsController sections] objectAtIndex:0];

    NSMutableArray *arrayItem = [[NSMutableArray alloc] init];
    // It's also a good idea to initialize i in your loop and not just declare it
    for (int i = 0; i<[sectionInfo numberOfObjects]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        TodayRecord *o = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        NSDate *now = [NSDate date];
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *components = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:now];
        
        [components setHour:0];
        [components setMinute:0];
        [components setSecond:0];
        NSDate *today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0]; //This variable should now be pointing at
        
        
        NSTimeInterval  intervals = [o.date timeIntervalSinceDate:today];
        //NSTimeInterval interval = 1002343.5432542;
        NSInteger time = intervals;
        
        NSNumber *n = [NSNumber numberWithInteger:time];
        NSNumber *milionSeconds = [[NSNumber alloc] init];
        milionSeconds = @( [n intValue] * 1000 );
        
        NSMutableArray *singePoint = [[NSMutableArray alloc] init];
        [singePoint addObject:milionSeconds];
        [singePoint addObject:o.value];
        [arrayItem addObject:singePoint];
        
     }
    
    [item setObject:arrayItem forKey:@"data"];
    NSMutableArray *parent = [[NSMutableArray alloc] init];
    [parent addObject:item];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parent options:NSJSONWritingPrettyPrinted error:&error];
    NSLog(@"%@",jsonData);
    return jsonData;
}


- (NSMutableArray *)getAllDataPoints{
    NSMutableArray *dataPoints = [[NSMutableArray alloc] init];
    
    
    NSArray *sections = [self.fetchedResultsController sections];
    if (sections){
        for (int i=0; i< [sections count];i++){
            id sectionInfo = [sections objectAtIndex:i];
            
            if (sectionInfo){
                for (int j=0; j<[sectionInfo numberOfObjects];j++){
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                    TodayRecord *o = [self.fetchedResultsController objectAtIndexPath:indexPath];
                    [dataPoints addObject:o];
                }
            }
        }
    }
    
    return dataPoints;
}

- (NSArray *)getAllDataPointsByDate{
    NSArray *datapoints = [self getAllDataPoints];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *reverseOrder = [datapoints sortedArrayUsingDescriptors:descriptors];
    
    return reverseOrder;
    
}



- (NSData *)generateDailyTrend{
    NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
    [item setObject:@"daily" forKey:@"name"];
    
    
    
    NSMutableArray *arrayItem = [[NSMutableArray alloc] init];
    NSArray *allDataPoints = [self getAllDataPointsByDate];
    // It's also a good idea to initialize i in your loop and not just declare it
    for (int i = 0; i<[allDataPoints count]; i++) {
        TodayRecord *o = [allDataPoints objectAtIndex:i];
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:[[NSDate alloc] init]];
        
        [components setHour:-[components hour]];
        [components setMinute:-[components minute]];
        [components setSecond:-[components second]];
//        NSDate *today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0]; //This variable should now be pointing at a date object that is the start of today (midnight);
        
        NSTimeInterval  intervals = [o.date timeIntervalSinceDate:self.workingDate];
        //NSTimeInterval interval = 1002343.5432542;
        NSInteger time = intervals;
        
        NSNumber *n = [NSNumber numberWithInteger:time];
        NSNumber *milionSeconds = [[NSNumber alloc] init];
        milionSeconds = @( [n intValue] * 1000 );
        
        NSMutableArray *singePoint = [[NSMutableArray alloc] init];
        [singePoint addObject:milionSeconds];
        [singePoint addObject:o.value];
        [arrayItem addObject:singePoint];
        
    }
    
    [item setObject:arrayItem forKey:@"data"];

    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:item options:NSJSONWritingPrettyPrinted error:&error];
    NSLog(@"%@",jsonData);
    return jsonData;
}

- (void) updateWebView{
    
    
    [self.myWebView  stopLoading ];
    [self.myWebView  reload];
 
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSData *jsonObj = [self generateDailyTrend];

    NSString *jsonString1 = [[NSString alloc] initWithData:jsonObj encoding:NSUTF8StringEncoding];
    NSString *jsonString = [jsonString1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    

    NSString *updateFunction=[[NSString alloc] initWithFormat:@"updateData('%@')",jsonString];
    
    
    [self.myWebView stringByEvaluatingJavaScriptFromString:updateFunction];
}


- (NSArray *)getAllDataPointsByType{
    NSArray *datapoints = [self getAllDataPoints];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"type" ascending:NO];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *reverseOrder = [datapoints sortedArrayUsingDescriptors:descriptors];
    
    return reverseOrder;
    
}

- (void)updateHistoryView{
    
    NSFetchRequest *fetchRequestItems = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *globalcontext =  [(cfAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    ProfileMasterData* myUser = [(cfAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];//Code for getting current user
    //NSManagedObjectContext *globalcontext = myUser.managedObjectContext;
    NSEntityDescription *entityItem = [NSEntityDescription entityForName:@"HistoryRecords" inManagedObjectContext:globalcontext];
    [fetchRequestItems setEntity:entityItem];
    
    //out of data store based on some paramator
    [fetchRequestItems setPredicate:[NSPredicate predicateWithFormat:@"toMaster == %@ and type == 2 and date == %@",myUser,self.workingDate]];
    
    //Sort by last edit ordered
    //NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:nil];
    [fetchRequestItems setSortDescriptors:sortDescriptors];
    
    
    NSError *error = nil;
    NSArray *fetchedObjects = [globalcontext executeFetchRequest:fetchRequestItems error:&error];
    if (fetchedObjects){
        HistoryRecords *historyAccount = nil;
        if ( [fetchedObjects count] == 0 ){
            historyAccount = [NSEntityDescription insertNewObjectForEntityForName:@"HistoryRecords" inManagedObjectContext:globalcontext];
            historyAccount.toMaster = myUser;
            historyAccount.type = [NSNumber numberWithInt:2];
            historyAccount.date = self.workingDate;

        }else{
            historyAccount = [fetchedObjects objectAtIndex:0];
        }
        //
        NSNumber *total = [[NSNumber alloc] initWithFloat:0];
        NSArray *allPoints = [self getAllDataPointsByType];
        int countOfObjects = 0;
        for (int i = 0; i<[allPoints count]; i++) {
            TodayRecord *o = [allPoints objectAtIndex:i];
            if ( [o.type isEqual:[NSNumber numberWithInt:2]] ){
                total = [NSNumber numberWithFloat:([total floatValue] + [o.value floatValue])];
                countOfObjects++;
            }
        }
        if (countOfObjects == 0){
            historyAccount.value = [NSNumber numberWithFloat:0.0f];
        }else{
            historyAccount.value = [NSNumber numberWithFloat:([total floatValue]/countOfObjects)];
        }
    }
    
    if (![globalcontext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    
}



#pragma mark - 实现oneDatePicker的监听方法
- (void) calendarDayTimelineView:(TKCalendarDayView*)calendarDay didMoveToDate:(NSDate*)date{
    

    
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSDate *now = date;
    NSDateComponents *comps = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                     fromDate:now];
    NSDate *selectedDate = [cal dateFromComponents:comps];
    
    
    if ([self.workingDate compare:selectedDate ] != NSOrderedSame ){
        self.workingDate = selectedDate;
        _fetchedResultsController = nil;
        [self.myDetailTableView reloadData];
        [self updateWebView];
    }
}


-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        [self.delegate PressureDidBack:self];
    }
    [super viewWillDisappear:animated];
}



@end
