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
    diaryToday.menuLabel = NSLocalizedString(@"Personal Diaries", nil);
    diaryToday.logoFileName = @"diary1.png";
    
    CFMenuTableViewCellContent *diaryHistory = [[CFMenuTableViewCellContent alloc] init];
    diaryHistory.menuLabel = NSLocalizedString(@"History Overview", nil);
    diaryHistory.logoFileName = @"clinic3.png";

    CFMenuTableViewCellContent *recommendFood = [[CFMenuTableViewCellContent alloc] init];
    recommendFood.menuLabel = NSLocalizedString(@"RecommendFood",nil);
    recommendFood.logoFileName = @"hot.png";

    CFMenuTableViewCellContent *network = [[CFMenuTableViewCellContent alloc] init];
    network.menuLabel = NSLocalizedString(@"Doctor Records",nil);
    network.logoFileName = @"surgeon1.png";
    
    menuContents = [NSArray arrayWithObjects: diaryToday,diaryHistory,recommendFood,network, nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //[self.menuTableView.layer setCornerRadius: 7.0f];
    //[self.menuTableView.layer setMasksToBounds:YES];
    
    [self initTable];
    
    
 
    
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                        initWithFrame:CGRectMake(0.0,self.view.frame.size.height-GAD_SIZE_320x50.height,
                                                 GAD_SIZE_320x50.width,
                                                 GAD_SIZE_320x50.height)];
    
    // 3
    self.admobBannerView.adUnitID = @"a14ec3f0a2028f2";  //to be change
    self.admobBannerView.rootViewController = self;
    self.admobBannerView.delegate = self;
    
    
    // 4
    [self.view addSubview:self.admobBannerView];
    GADRequest *request = [GADRequest request];
    

    request.testDevices = @[ @"d07c07b9088108d8b4d7ffc109443888" ];
    [self.admobBannerView loadRequest:request];
    
}

- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
    [self.admobBannerView removeFromSuperview];
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
