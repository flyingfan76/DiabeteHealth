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

@implementation cfHistoryViewController

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
    
    self.myWebView.delegate = self;
    //[NSURLProtocol registerClass:[cfAjaxURLProtocol class]];
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"history" ofType:@"html"];
    NSURL *instructionsURL = [NSURL fileURLWithPath:htmlFile];
    self.myWebView.scrollView.scrollEnabled = TRUE;
    self.myWebView.scalesPageToFit = TRUE;
	[self.myWebView loadRequest:[NSURLRequest requestWithURL:instructionsURL]];
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
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSData *jsonObj = [self generateOnePreSugarSeries];
    NSString *jsonString1 = [[NSString alloc] initWithData:jsonObj encoding:NSUTF8StringEncoding];
    NSString *jsonString = [jsonString1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    
    NSData *jsonAObj = [self generateOneAfterSugarSeries];
    NSString *jsonString2 = [[NSString alloc] initWithData:jsonAObj encoding:NSUTF8StringEncoding];
    NSString *jsonStringA = [jsonString2 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSString *updateFunction=[[NSString alloc] initWithFormat:@"updateSugarData('%@','%@')",jsonString,jsonStringA];
    
    
    [self.myWebView stringByEvaluatingJavaScriptFromString:updateFunction];
    
    
    NSData *jsonP = [self generateOneAfterSugarSeries];
    NSString *jsonString2P = [[NSString alloc] initWithData:jsonP encoding:NSUTF8StringEncoding];
    NSString *jsonStringP = [jsonString2P stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSString *updateFunctionP =[[NSString alloc] initWithFormat:@"updatePressureData('%@')",jsonStringP];
    
     [self.myWebView stringByEvaluatingJavaScriptFromString:updateFunctionP];
    
    
}


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
    [self updateWebView];
    
}

- (void) updateWebView{
    
    
    [self.myWebView  stopLoading ];
    [self.myWebView  reload];
    
}

@end
