//
//  CFMedicalRecordTableTableViewController.m
//  DiabetesCare
//
//  Created by Chen, Fan on 8/26/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import "CFMedicalRecordTableTableViewController.h"
#import "CFMedicalRecordTableCellViewTableViewCell.h"
#import "cfAppDelegate.h"
#import "CFEditMedicalRecordViewController.h"

@interface CFMedicalRecordTableTableViewController ()

@end

@implementation CFMedicalRecordTableTableViewController{

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 381, 320, 20)];
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 300, 16)];
    
    int count = 0;
    NSArray * sections = [self.fetchedResultsController sections];
    if (sections){
        id sectionInfo = [sections objectAtIndex:0];
        if(sectionInfo){
            count =  [sectionInfo numberOfObjects];
        }
    }

    
    labelView.text = [NSString stringWithFormat:NSLocalizedString(@"Total %d records",nil),count];
    labelView.tag = 101;
    labelView.textAlignment = NSTextAlignmentCenter;
    labelView.backgroundColor =  [UIColor colorWithRed:122.0f/255.0f
                                                     green:122.0f/255.0f
                                                      blue:122.0f/255.0f
                                                     alpha:1.0f];
    [headerView addSubview:labelView];
    self.tableView.tableHeaderView = headerView;
    
    self.bannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, 320, 50)];
    [self.bannerView setDelegate:self];
    [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
    
    // Assumes the banner view is just off the bottom of the screen.
    self.bannerView.frame = CGRectOffset(self.bannerView.frame, 0, -self.bannerView.frame.size.height);
    
    [UIView commitAnimations];
    
    [self.view addSubview:self.bannerView];
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.bannerView){
        return self.bannerView.frame.size.height;
    }
    return GAD_SIZE_320x50.height;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.bannerView){
        return self.bannerView;
    }else if (self.admobBannerView){
        return self.admobBannerView;
    }
    return [[UIView alloc] initWithFrame:CGRectZero];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
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


- (void)configureCell:(CFMedicalRecordTableCellViewTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    HistoryMedicalRecord *info =  [_fetchedResultsController objectAtIndexPath:indexPath];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    
    
    NSString *stringFromDate = [formatter stringFromDate:info.date];
    cell.myMedicalTime.text = stringFromDate;
 
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFMedicalRecordTableCellViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"medicalrecord" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[CFMedicalRecordTableCellViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"medicalrecord"] ;
    }
    
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
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



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    
    HistoryMedicalRecord *info = [_fetchedResultsController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
    CFEditMedicalRecordViewController *destinationController = [segue destinationViewController];
    
    
    if ( [[segue identifier] isEqualToString:@"detailMedicalSegue"]){
        
        destinationController.currentRecord = info;
    }

    
    

    // Pass the selected object to the new view controller.
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
    NSEntityDescription *entityItem = [NSEntityDescription entityForName:@"HistoryMedicalRecord" inManagedObjectContext:globalcontext];
    [fetchRequestItems setEntity:entityItem];
    
    
    //out of data store based on some paramator
    [fetchRequestItems setPredicate:[NSPredicate predicateWithFormat:@"toMaster == %@ ",myUser]];
    
    //Sort by last edit ordered
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sort,nil];
    [fetchRequestItems setSortDescriptors:sortDescriptors];
    
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:fetchRequestItems managedObjectContext:globalcontext
                                                             sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController = aFetchedResultsController;
	NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
	    NSLog(@"Core data error %@, %@", error, [error userInfo]);
	    abort();
	}
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(CFMedicalRecordTableCellViewTableViewCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
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
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
    
    [self updateTableHeader];
    
    
}

- (void) updateTableHeader {
    
    int count = 0;
    NSArray * sections = [self.fetchedResultsController sections];
    if (sections){
        id sectionInfo = [sections objectAtIndex:0];
        if(sectionInfo){
            count =  [sectionInfo numberOfObjects];
        }
    }
    
    UILabel *textView = (UILabel*)[self.tableView.tableHeaderView viewWithTag:101];
    

    
    textView.text = [NSString stringWithFormat:NSLocalizedString(@"Total %d records",nil),count];
}


@end
