//
//  cfViewController.m
//  DiabetesCare
//
//  Created by Chen, Fan on 7/8/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import "CFRootViewController.h"
#import "CFMenuTableViewCell.h"
#import "CFMenuTableViewCellContent.h"
#import "../utilities.h"

@interface CFRootViewController ()

- (void) initTable;

@end


@implementation CFRootViewController
{
    NSArray * menuContents;
}


- (void) initTable
{
    CFMenuTableViewCellContent *diaryToday = [[CFMenuTableViewCellContent alloc] init];
    diaryToday.menuLabel = NSLocalizedString(@"Diaries", nil);
    diaryToday.logoFileName = @"diarytoday.png";
    
    CFMenuTableViewCellContent *diaryHistory = [[CFMenuTableViewCellContent alloc] init];
    diaryHistory.menuLabel = NSLocalizedString(@"History Review", nil);
    diaryHistory.logoFileName = @"diaryhistory.png";

    CFMenuTableViewCellContent *recommendFood = [[CFMenuTableViewCellContent alloc] init];
    recommendFood.menuLabel = NSLocalizedString(@"RecommendFood",nil);
    recommendFood.logoFileName = @"food.png";

    CFMenuTableViewCellContent *network = [[CFMenuTableViewCellContent alloc] init];
    network.menuLabel = NSLocalizedString(@"Diabetes Network",nil);
    network.logoFileName = @"unnamed.png";
    
    menuContents = [NSArray arrayWithObjects: diaryToday,diaryHistory,recommendFood,network, nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.menuTableView.layer setCornerRadius: 7.0f];
    [self.menuTableView.layer setMasksToBounds:YES];
    
    [self initTable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return menuContents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cfMenuTableCell";
    CFMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[CFMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // configure your cell here...
    
    cell.label.text = [[menuContents objectAtIndex:indexPath.row] menuLabel];
    cell.imagePlaceHolder.image = [UIImage imageNamed:[[menuContents objectAtIndex:indexPath.row] logoFileName]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //trigger another view
    if (indexPath.row == 0 ){
        [self performSegueWithIdentifier:@"diabetesTodaySegue" sender:self];
        
    }else if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"diabetesHistorySegue" sender:self];
    }else if (indexPath.row == 2){
        [self performSegueWithIdentifier:@"recommendedFoodSegue" sender:self];
    }else if (indexPath.row == 3){
        //[self performSegueWithIdentifier:@"recommendedFoodSegue" sender:self];
        [self performSegueWithIdentifier:@"medicalRecordSegue" sender:self];
    }
   
 
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"segue identififer = %@",segue.identifier);
    
//    if( [[segue identifier] isEqualToString:@"diabetesTodaySegue"]){
//        //CFDailyRecordTableViewController *destinationController = [segue destinationViewController];
//    }
  
}

@end
