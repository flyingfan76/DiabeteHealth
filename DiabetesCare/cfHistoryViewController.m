//
//  cfHistoryViewController.m
//  DiabetesCare
//
//  Created by Chen, Fan on 8/1/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import "cfHistoryViewController.h"
#import "cfAppDelegate.h"
#import "HistoryRecords.h"

@interface cfHistoryViewController ()

@end

@implementation cfHistoryViewController{

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
    
//    self.myWebView.delegate = self;
//    //[NSURLProtocol registerClass:[cfAjaxURLProtocol class]];
//    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"history" ofType:@"html"];
//    NSURL *instructionsURL = [NSURL fileURLWithPath:htmlFile];
//    self.myWebView.scrollView.scrollEnabled = TRUE;
//    self.myWebView.scalesPageToFit = TRUE;
//	[self.myWebView loadRequest:[NSURLRequest requestWithURL:instructionsURL]];
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = NSLocalizedString(@"Loading graph data...", nil);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSDate *startDate = [NSDate dateWithTimeIntervalSince1970: 1351036800];
        NSDate *endDate = [NSDate date];
        
        NSArray *graphObjects = [self GenerateGraphDataObjectsArrayofPreSuger];
        NSArray *secondGraphObjects = [self GenerateGraphDataObjectsArrayofAfterSuger];
        NSArray *pressureGraphObjects = [self GenerateGraphDataObjectsArrayofPressure];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if([graphObjects count] > 0){
                
                self.graphView = [[GraphView alloc] initWithFrame:DEFAULT_GRAPH_VIEW_FRAME objectsArray:graphObjects
                                               secondObjectsArray:secondGraphObjects startDate:startDate endDate:endDate delegate:self];
                
                self.graphView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gi.png"]];
                
                
                [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
                
                // Assumes the banner view is just off the bottom of the screen.
                self.graphView.frame = CGRectOffset(self.graphView.frame, 0, 45);
                
                [UIView commitAnimations];
                
                
                [self.view insertSubview:self.graphView atIndex:0];
            }
            
            if([pressureGraphObjects count] > 0){
                
                self.pressureGraphView = [[GraphView alloc] initWithFrame:DEFAULT_GRAPH_VIEW_FRAME objectsArray:pressureGraphObjects secondObjectsArray:nil startDate:startDate endDate:endDate delegate:self];
                
                
                self.pressureGraphView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bloodpressure.png"]];
                
                [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
                
                // Assumes the banner view is just off the bottom of the screen.
                self.pressureGraphView.frame = CGRectOffset(self.graphView.frame, 0, 192);
                
                [UIView commitAnimations];
                
                
                [self.view insertSubview:self.pressureGraphView atIndex:1];
            }

            
            
            
        });
    });

    
    self.bannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, 320, 50)];
    [self.bannerView setDelegate:self];
    [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
    
    // Assumes the banner view is just off the bottom of the screen.
    self.bannerView.frame = CGRectOffset(self.bannerView.frame, 0, - self.bannerView.frame.size.height);
    
    [UIView commitAnimations];
    
    [self.view addSubview:self.bannerView];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

}

- (void)graphViewDidUpdate:(GraphView *)view{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    self.hud = nil;
}

- (void)graphViewWillUpdate:(GraphView *)view{
    
    if(!self.hud){
        
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.labelText = NSLocalizedString(@"Loading graph data...", @"");
    }
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

- (NSArray *)GenerateGraphDataObjectsArrayofPreSuger{
    

    
    id  sectionInfo =[[self.fetchedPreSugarResultsController sections] objectAtIndex:0];
    
    NSMutableArray *arrayItem =  [NSMutableArray array];;
    // It's also a good idea to initialize i in your loop and not just declare it
    for (int i = 0; i<[sectionInfo numberOfObjects]; i++) {
        
        GraphDataObject *object = [[GraphDataObject alloc] init];
        

        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        HistoryRecords *o = [self.fetchedPreSugarResultsController objectAtIndexPath:indexPath];
        

        NSDecimalNumber *dividing = [NSDecimalNumber decimalNumberWithString:@"50"];
        
        NSDecimalNumber *decNum = [NSDecimalNumber decimalNumberWithDecimal:[o.value decimalValue]];
        NSDecimalNumber *valueNum = [decNum decimalNumberByDividingBy:dividing];
        
        object.time = o.date;
        object.value = valueNum;
        [arrayItem addObject:object];
        
    }
    
    //add one days more fake data
    if ([arrayItem count] == 0){
        GraphDataObject * object = [[GraphDataObject alloc] init];
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDate *date = [NSDate date];
        NSDateComponents *comps = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                         fromDate:date];
        
        
        object.time = [cal dateFromComponents:comps]; //This variable should now be pointing at
        object.value = 0;
        [arrayItem addObject:object];
    }
    
    return arrayItem;
}

- (NSArray *)GenerateGraphDataObjectsArrayofAfterSuger{
    
    
    
    id  sectionInfo =[[self.fetchedAfterSugarResultsController sections] objectAtIndex:0];
    
    NSMutableArray *arrayItem =  [NSMutableArray array];;
    // It's also a good idea to initialize i in your loop and not just declare it
    for (int i = 0; i<[sectionInfo numberOfObjects]; i++) {
        
        GraphDataObject *object = [[GraphDataObject alloc] init];
        
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        HistoryRecords *o = [self.fetchedAfterSugarResultsController objectAtIndexPath:indexPath];
        
        
        NSDecimalNumber *dividing = [NSDecimalNumber decimalNumberWithString:@"50"];
        
        NSDecimalNumber *decNum = [NSDecimalNumber decimalNumberWithDecimal:[o.value decimalValue]];
        NSDecimalNumber *valueNum = [decNum decimalNumberByDividingBy:dividing];
        
        object.time = o.date;
        object.value = valueNum;
        [arrayItem addObject:object];
        
    }
    
    //add one days more fake data
    if ([arrayItem count] == 0){
        GraphDataObject * object = [[GraphDataObject alloc] init];
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDate *date = [NSDate date];
        NSDateComponents *comps = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                         fromDate:date];
        
        
        object.time = [cal dateFromComponents:comps]; //This variable should now be pointing at
        object.value = 0;
        [arrayItem addObject:object];
    }

    
    return arrayItem;
}

- (NSArray *)GenerateGraphDataObjectsArrayofPressure{
    
    
    
    id  sectionInfo =[[self.fetchedPressureResultsController sections] objectAtIndex:0];
    
    NSMutableArray *arrayItem =  [NSMutableArray array];;
    // It's also a good idea to initialize i in your loop and not just declare it
    for (int i = 0; i<[sectionInfo numberOfObjects]; i++) {
        
        GraphDataObject *object = [[GraphDataObject alloc] init];
        
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        HistoryRecords *o = [self.fetchedPressureResultsController objectAtIndexPath:indexPath];
        
        
        NSDecimalNumber *dividing = [NSDecimalNumber decimalNumberWithString:@"50"];
        
        NSDecimalNumber *decNum = [NSDecimalNumber decimalNumberWithDecimal:[o.value decimalValue]];
        NSDecimalNumber *valueNum = [decNum decimalNumberByDividingBy:dividing];
        
        object.time = o.date;
        object.value = valueNum;
        [arrayItem addObject:object];
        
    }
    
    //add one days more fake data
    if ([arrayItem count] == 0){
        GraphDataObject * object = [[GraphDataObject alloc] init];
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDate *date = [NSDate date];
        NSDateComponents *comps = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                         fromDate:date];
        
        
        object.time = [cal dateFromComponents:comps]; //This variable should now be pointing at
        object.value = 0;
        [arrayItem addObject:object];
    }

    
    return arrayItem;
}



- (NSData *)generateOnePreSugarSeries{
    NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
    [item setObject:@"before" forKey:@"name"];
    
    
    id  sectionInfo =[[self.fetchedPreSugarResultsController sections] objectAtIndex:0];
    
    NSMutableArray *arrayItem = [[NSMutableArray alloc] init];
    // It's also a good idea to initialize i in your loop and not just declare it
    for (int i = 0; i<[sectionInfo numberOfObjects]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        HistoryRecords *o = [self.fetchedPreSugarResultsController objectAtIndexPath:indexPath];
        
        NSTimeInterval  epoch = (long)[o.date timeIntervalSince1970];
        //NSTimeInterval interval = 1002343.5432542;
        NSInteger time = epoch;
        
        NSNumber *n = [NSNumber numberWithLongLong:time];
        NSNumber *milionSeconds = [[NSNumber alloc] init];
        milionSeconds = @( [n longLongValue] * 1000 );
        
        NSMutableArray *singePoint = [[NSMutableArray alloc] init];
        [singePoint addObject:milionSeconds];
        [singePoint addObject:o.value];
        [arrayItem addObject:singePoint];
        
    }
    
    if ( [sectionInfo numberOfObjects] == 0){
        NSDate *now = [NSDate date];
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *components = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:now];
        
        [components setHour:0];
        [components setMinute:0];
        [components setSecond:0];
        NSDate *today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0]; //This variable should now be pointing at
        NSTimeInterval  epoch = [today timeIntervalSince1970];
        //NSTimeInterval interval = 1002343.5432542;
        NSInteger time = epoch;
        
        NSNumber *n = [NSNumber numberWithInteger:time];
        //        NSNumber *milionSeconds = [[NSNumber alloc] init];
        //        milionSeconds = @( [n intValue] * 1000 );
        
        NSMutableArray *singePoint = [[NSMutableArray alloc] init];
        [singePoint addObject:n];
        [singePoint addObject:nil];
        [arrayItem addObject:singePoint];

    }
    
    [item setObject:arrayItem forKey:@"data"];
    //    NSMutableArray *parent = [[NSMutableArray alloc] init];
    //    [parent addObject:item];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:item options:NSJSONWritingPrettyPrinted error:&error];
    NSLog(@"%@",jsonData);
    return jsonData;
}


- (NSData *)generateOneAfterSugarSeries{
    NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
    [item setObject:@"before" forKey:@"name"];
    
    
    id  sectionInfo =[[self.fetchedAfterSugarResultsController sections] objectAtIndex:0];
    
    NSMutableArray *arrayItem = [[NSMutableArray alloc] init];
    // It's also a good idea to initialize i in your loop and not just declare it
    for (int i = 0; i<[sectionInfo numberOfObjects]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        HistoryRecords *o = [self.fetchedAfterSugarResultsController objectAtIndexPath:indexPath];
        
        NSTimeInterval  epoch = (long)[o.date timeIntervalSince1970];
        //NSTimeInterval interval = 1002343.5432542;
        NSInteger time = epoch;
        
        NSNumber *n = [NSNumber numberWithLongLong:time];
        NSNumber *milionSeconds = [[NSNumber alloc] init];
        milionSeconds = @( [n longLongValue] * 1000 );
        
        NSMutableArray *singePoint = [[NSMutableArray alloc] init];
        [singePoint addObject:milionSeconds];
        [singePoint addObject:o.value];
        [arrayItem addObject:singePoint];
        
    }
    
    if ( [sectionInfo numberOfObjects] == 0){
        NSDate *now = [NSDate date];
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *components = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:now];
        
        [components setHour:0];
        [components setMinute:0];
        [components setSecond:0];
        NSDate *today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0]; //This variable should now be pointing at
        NSTimeInterval  epoch = [today timeIntervalSince1970];
        //NSTimeInterval interval = 1002343.5432542;
        NSInteger time = epoch;
        
        NSNumber *n = [NSNumber numberWithInteger:time];
        //        NSNumber *milionSeconds = [[NSNumber alloc] init];
        //        milionSeconds = @( [n intValue] * 1000 );
        
        NSMutableArray *singePoint = [[NSMutableArray alloc] init];
        [singePoint addObject:n];
        [singePoint addObject:nil];
        [arrayItem addObject:singePoint];
        
    }
    
    [item setObject:arrayItem forKey:@"data"];
    //    NSMutableArray *parent = [[NSMutableArray alloc] init];
    //    [parent addObject:item];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:item options:NSJSONWritingPrettyPrinted error:&error];
    NSLog(@"%@",jsonData);
    return jsonData;
}



- (NSData *)generateOnePressureSeries{
    NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
    [item setObject:@"before" forKey:@"name"];
    
    
    id  sectionInfo =[[self.fetchedPressureResultsController sections] objectAtIndex:0];
    
    NSMutableArray *arrayItem = [[NSMutableArray alloc] init];
    // It's also a good idea to initialize i in your loop and not just declare it
    for (int i = 0; i<[sectionInfo numberOfObjects]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        HistoryRecords *o = [self.fetchedPressureResultsController objectAtIndexPath:indexPath];
        
        NSTimeInterval  epoch = (long)[o.date timeIntervalSince1970];
        //NSTimeInterval interval = 1002343.5432542;
        NSInteger time = epoch;
        
        NSNumber *n = [NSNumber numberWithLongLong:time];
        NSNumber *milionSeconds = [[NSNumber alloc] init];
        milionSeconds = @( [n longLongValue] * 1000 );
        
        NSMutableArray *singePoint = [[NSMutableArray alloc] init];
        [singePoint addObject:milionSeconds];
        [singePoint addObject:o.value];
        [arrayItem addObject:singePoint];
        
    }
    
    if ( [sectionInfo numberOfObjects] == 0){
        NSDate *now = [NSDate date];
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *components = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:now];
        
        [components setHour:0];
        [components setMinute:0];
        [components setSecond:0];
        NSDate *today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0]; //This variable should now be pointing at
        NSTimeInterval  epoch = [today timeIntervalSince1970];
        //NSTimeInterval interval = 1002343.5432542;
        NSInteger time = epoch;
        
        NSNumber *n = [NSNumber numberWithInteger:time];
        //        NSNumber *milionSeconds = [[NSNumber alloc] init];
        //        milionSeconds = @( [n intValue] * 1000 );
        
        NSMutableArray *singePoint = [[NSMutableArray alloc] init];
        [singePoint addObject:n];
        [singePoint addObject:nil];
        [arrayItem addObject:singePoint];
        
    }
    
    [item setObject:arrayItem forKey:@"data"];
    //    NSMutableArray *parent = [[NSMutableArray alloc] init];
    //    [parent addObject:item];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:item options:NSJSONWritingPrettyPrinted error:&error];
    NSLog(@"%@",jsonData);
    return jsonData;
}


#pragma mark - UIWebViewDelegate
//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    NSData *jsonObj = [self generateOnePreSugarSeries];
//    NSString *jsonString1 = [[NSString alloc] initWithData:jsonObj encoding:NSUTF8StringEncoding];
//    NSString *jsonString = [jsonString1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    
//    
//    NSData *jsonAObj = [self generateOneAfterSugarSeries];
//    NSString *jsonString2 = [[NSString alloc] initWithData:jsonAObj encoding:NSUTF8StringEncoding];
//    NSString *jsonStringA = [jsonString2 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    
//    NSString *updateFunction=[[NSString alloc] initWithFormat:@"updateSugarData('%@','%@')",jsonString,jsonStringA];
//    
//    
//    [self.myWebView stringByEvaluatingJavaScriptFromString:updateFunction];
//    
//    
//    NSData *jsonP = [self generateOneAfterSugarSeries];
//    NSString *jsonString2P = [[NSString alloc] initWithData:jsonP encoding:NSUTF8StringEncoding];
//    NSString *jsonStringP = [jsonString2P stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    
//    NSString *updateFunctionP =[[NSString alloc] initWithFormat:@"updatePressureData('%@')",jsonStringP];
//    
//     [self.myWebView stringByEvaluatingJavaScriptFromString:updateFunctionP];
//    
//    
//}


#pragma mark - fetchResultsController


-(NSFetchedResultsController *)fetchedPreSugarResultsController {
    if (_fetchedPreSugarResultsController != nil) {
        return _fetchedPreSugarResultsController;
    }
    
    NSFetchRequest *fetchRequestItems = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *globalcontext =  [(cfAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    ProfileMasterData* myUser = [(cfAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];//Code for getting current user
    //NSManagedObjectContext *globalcontext = myUser.managedObjectContext;
    NSEntityDescription *entityItem = [NSEntityDescription entityForName:@"HistoryRecords" inManagedObjectContext:globalcontext];
    [fetchRequestItems setEntity:entityItem];
    
    //out of data store based on some paramator
    [fetchRequestItems setPredicate:[NSPredicate predicateWithFormat:@"toMaster == %@",myUser]];
    [fetchRequestItems setPredicate:[NSPredicate predicateWithFormat:@"type == 0"]];
    
    //Sort by last edit ordered
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sort,nil];
    [fetchRequestItems setSortDescriptors:sortDescriptors];
    
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:fetchRequestItems managedObjectContext:globalcontext
                                                             sectionNameKeyPath:nil cacheName:@"history"];
    
    self.fetchedPreSugarResultsController = aFetchedResultsController;
	NSError *error = nil;
    @try{
        if (![self.fetchedPreSugarResultsController performFetch:&error]) {
            NSLog(@"Core data error %@, %@", error, [error userInfo]);
            abort();
        }
    }@catch(NSException * e)
    {
        NSLog(@"Exception (%@)",e);
    }
    //_fetchedPreSugarResultsController.delegate = self;
    
    return _fetchedPreSugarResultsController;
}

-(NSFetchedResultsController *)fetchedAfterSugarResultsController {
    if (_fetchedAfterSugarResultsController != nil) {
        return _fetchedAfterSugarResultsController;
    }
    
    NSFetchRequest *fetchRequestItems = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *globalcontext =  [(cfAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    ProfileMasterData* myUser = [(cfAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];//Code for getting current user
    //NSManagedObjectContext *globalcontext = myUser.managedObjectContext;
    NSEntityDescription *entityItem = [NSEntityDescription entityForName:@"HistoryRecords" inManagedObjectContext:globalcontext];
    [fetchRequestItems setEntity:entityItem];
    
    //out of data store based on some paramator
    [fetchRequestItems setPredicate:[NSPredicate predicateWithFormat:@"toMaster == %@",myUser]];
    [fetchRequestItems setPredicate:[NSPredicate predicateWithFormat:@"type == 1"]];
    
    //Sort by last edit ordered
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sort,nil];
    [fetchRequestItems setSortDescriptors:sortDescriptors];
    
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:fetchRequestItems managedObjectContext:globalcontext
                                                             sectionNameKeyPath:nil cacheName:@"history"];
    
    self.fetchedAfterSugarResultsController = aFetchedResultsController;
	NSError *error = nil;
    @try{
        if (![self.fetchedAfterSugarResultsController performFetch:&error]) {
            NSLog(@"Core data error %@, %@", error, [error userInfo]);
            abort();
        }
    }@catch(NSException * e)
    {
        NSLog(@"Exception (%@)",e);
    }
    //_fetchedPreSugarResultsController.delegate = self;
    
    return _fetchedAfterSugarResultsController;
}

-(NSFetchedResultsController *)fetchedPressureResultsController {
    if (_fetchedPressureResultsController != nil) {
        return _fetchedPressureResultsController;
    }
    
    NSFetchRequest *fetchRequestItems = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *globalcontext =  [(cfAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    ProfileMasterData* myUser = [(cfAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];//Code for getting current user
    //NSManagedObjectContext *globalcontext = myUser.managedObjectContext;
    NSEntityDescription *entityItem = [NSEntityDescription entityForName:@"HistoryRecords" inManagedObjectContext:globalcontext];
    [fetchRequestItems setEntity:entityItem];
    
    //out of data store based on some paramator
    [fetchRequestItems setPredicate:[NSPredicate predicateWithFormat:@"toMaster == %@",myUser]];
    [fetchRequestItems setPredicate:[NSPredicate predicateWithFormat:@"type == 0"]];
    
    //Sort by last edit ordered
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sort,nil];
    [fetchRequestItems setSortDescriptors:sortDescriptors];
    
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:fetchRequestItems managedObjectContext:globalcontext
                                                             sectionNameKeyPath:nil cacheName:@"history"];
    
    self.fetchedPressureResultsController = aFetchedResultsController;
	NSError *error = nil;
    @try{
        if (![self.fetchedPressureResultsController performFetch:&error]) {
            NSLog(@"Core data error %@, %@", error, [error userInfo]);
            abort();
        }
    }@catch(NSException * e)
    {
        NSLog(@"Exception (%@)",e);
    }
    //_fetchedPreSugarResultsController.delegate = self;
    
    return _fetchedPressureResultsController;
}



#pragma mark - control delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            break;
            
        case NSFetchedResultsChangeDelete:
            break;
            
        case NSFetchedResultsChangeUpdate:
            break;
            
        case NSFetchedResultsChangeMove:
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            break;
            
        case NSFetchedResultsChangeDelete:
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
//    [self updateWebView];
    
}

//- (void) updateWebView{
//    
//    
//    [self.myWebView  stopLoading ];
//    [self.myWebView  reload];
//    
//}

@end
