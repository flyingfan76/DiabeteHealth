//
//  cfRecommendedFoodedTableViewController.m
//  DiabetesCare
//
//  Created by Chen, Fan on 8/6/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import "cfRecommendedFoodedTableViewController.h"
#import "RecipeTableCell.h"
#import "RecipeDetailViewController.h"
#import "Recipe.h"

@interface cfRecommendedFoodedTableViewController ()

@end

@implementation cfRecommendedFoodedTableViewController
{
    NSArray *recipes;
    NSArray *searchResults;

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
    // Initialize the recipes array
    Recipe *recipe1 = [Recipe new];
    recipe1.name = NSLocalizedString(@"Tuna Steak", nil);
    recipe1.prepTime = @"40 min";
    recipe1.image = @"Tuna_Steak_With_Apricote.png";
    recipe1.ingredients = [NSArray arrayWithObjects:NSLocalizedString(@"Tuna Steak 1",nil),NSLocalizedString(@"Tuna Steak 2",nil),NSLocalizedString(@"Tuna Steak 3",nil),NSLocalizedString(@"Tuna Steak 4",nil),NSLocalizedString(@"Tuna Steak 5",nil),NSLocalizedString(@"Tuna Steak 6",nil),NSLocalizedString(@"Tuna Steak 7",nil),NSLocalizedString(@"Tuna Steak 8",nil),NSLocalizedString(@"Tuna Steak 9",nil),NSLocalizedString(@"Tuna Steak 10",nil), nil];
    
    Recipe *recipe2 = [Recipe new];
    recipe2.name = NSLocalizedString(@"Mushroom Risotto",nil);
    recipe2.prepTime = @"30 min";
    recipe2.image = @"mushroom_risotto.jpg";
    recipe2.ingredients = [NSArray arrayWithObjects:NSLocalizedString(@"Mushroom Risotto 1",nil), NSLocalizedString(@"Mushroom Risotto 2",nil),NSLocalizedString(@"Mushroom Risotto 3",nil),NSLocalizedString(@"Mushroom Risotto 4",nil),NSLocalizedString(@"Mushroom Risotto 5",nil),NSLocalizedString(@"Mushroom Risotto 6",nil),NSLocalizedString(@"Mushroom Risotto 7",nil),NSLocalizedString(@"Mushroom Risotto 8",nil), nil];
    
    Recipe *recipe3 = [Recipe new];
    recipe3.name = NSLocalizedString(@"Roasted Mushroom",nil);
    recipe3.prepTime = @"45 min";
    recipe3.image = @"Roasted_Mushroom.png";
    recipe3.ingredients = [NSArray arrayWithObjects:NSLocalizedString(@"Roasted Mushroom 1",nil), NSLocalizedString(@"Roasted Mushroom 2",nil),NSLocalizedString(@"Roasted Mushroom 3",nil),NSLocalizedString(@"Roasted Mushroom 4",nil),NSLocalizedString(@"Roasted Mushroom 5",nil),NSLocalizedString(@"Roasted Mushroom 6",nil),NSLocalizedString(@"Roasted Mushroom 7",nil),nil];
    
    Recipe *recipe4 = [Recipe new];
    recipe4.name = NSLocalizedString(@"Lemon Chicken",nil);
    recipe4.prepTime = @"50 min";
    recipe4.image = @"Lemon_Parsley_chicken.png";
    recipe4.ingredients = [NSArray arrayWithObjects:NSLocalizedString(@"Lemon Chicken 1",nil), NSLocalizedString(@"Lemon Chicken 2",nil),NSLocalizedString(@"Lemon Chicken 3",nil),NSLocalizedString(@"Lemon Chicken 4",nil),NSLocalizedString(@"Lemon Chicken 5",nil),NSLocalizedString(@"Lemon Chicken 6",nil),NSLocalizedString(@"Lemon Chicken 7",nil),NSLocalizedString(@"Lemon Chicken 8",nil),nil];
    
    Recipe *recipe5 = [Recipe new];
    recipe5.name = NSLocalizedString(@"Grilled Salmon",nil);
    recipe5.prepTime = @"20 min";
    recipe5.image = @"Dill_Salmon.png";
    recipe5.ingredients = [NSArray arrayWithObjects:NSLocalizedString(@"Grilled Salmon 1",nil), NSLocalizedString(@"Grilled Salmon 2",nil),NSLocalizedString(@"Grilled Salmon 3",nil),NSLocalizedString(@"Grilled Salmon 4",nil),NSLocalizedString(@"Grilled Salmon 5",nil),NSLocalizedString(@"Grilled Salmon 6",nil),NSLocalizedString(@"Grilled Salmon 7",nil),nil];
    
    Recipe *recipe6 = [Recipe new];
    recipe6.name = NSLocalizedString(@"Chicken Casserole",nil);
    recipe6.prepTime = @"1 hour";
    recipe6.image = @"chicken_chickpea_casserole.png";
    recipe6.ingredients = [NSArray arrayWithObjects:NSLocalizedString(@"Chicken Casserole 1",nil), NSLocalizedString(@"Chicken Casserole 2",nil),NSLocalizedString(@"Chicken Casserole 3",nil),NSLocalizedString(@"Chicken Casserole 4",nil),NSLocalizedString(@"Chicken Casserole 5",nil),NSLocalizedString(@"Chicken Casserole 6",nil),NSLocalizedString(@"Chicken Casserole 7",nil),NSLocalizedString(@"Chicken Casserole 8",nil),NSLocalizedString(@"Chicken Casserole 9",nil),NSLocalizedString(@"Chicken Casserole 10",nil),nil];
    
    Recipe *recipe7 = [Recipe new];
    recipe7.name = NSLocalizedString(@"Vegetarian Chili",nil);
    recipe7.prepTime = @"30 min";
    recipe7.image = @"vegetarian_chocolate_chili.png";
    recipe7.ingredients = [NSArray arrayWithObjects:NSLocalizedString(@"Vegetarian Chili 1",nil), NSLocalizedString(@"Vegetarian Chili 2",nil),NSLocalizedString(@"Vegetarian Chili 3",nil),NSLocalizedString(@"Vegetarian Chili 4",nil),NSLocalizedString(@"Vegetarian Chili 5",nil),NSLocalizedString(@"Vegetarian Chili 6",nil),NSLocalizedString(@"Vegetarian Chili 7",nil),NSLocalizedString(@"Vegetarian Chili 8",nil),NSLocalizedString(@"Vegetarian Chili 9",nil),NSLocalizedString(@"Vegetarian Chili 10",nil),nil];
    
    Recipe *recipe8 = [Recipe new];
    recipe8.name = NSLocalizedString(@"Pork Soap",nil);
    recipe8.prepTime = @"40 min";
    recipe8.image = @"pork_apple_sage_soup.png";
    recipe8.ingredients = [NSArray arrayWithObjects:NSLocalizedString(@"Pork Soap 1",nil), NSLocalizedString(@"Pork Soap 2",nil),NSLocalizedString(@"Pork Soap 3",nil),NSLocalizedString(@"Pork Soap 4",nil),NSLocalizedString(@"Pork Soap 5",nil),NSLocalizedString(@"Pork Soap 6",nil),NSLocalizedString(@"Pork Soap 7",nil),NSLocalizedString(@"Pork Soap 8",nil),nil];

    Recipe *recipe9 = [Recipe new];
    recipe9.name = NSLocalizedString(@"Pasta Bake",nil);
    recipe9.prepTime = @"60 min";
    recipe9.image = @"Tuscan_Pasta_Bake.png";
    recipe9.ingredients = [NSArray arrayWithObjects:NSLocalizedString(@"Pasta Bake 1",nil), NSLocalizedString(@"Pasta Bake 2",nil),NSLocalizedString(@"Pasta Bake 3",nil),NSLocalizedString(@"Pasta Bake 4",nil),NSLocalizedString(@"Pasta Bake 5",nil),NSLocalizedString(@"Pasta Bake 6",nil),NSLocalizedString(@"Pasta Bake 7",nil),NSLocalizedString(@"Pasta Bake 8",nil),NSLocalizedString(@"Pasta Bake 9",nil),nil];

    
    Recipe *recipe10 = [Recipe new];
    recipe10.name = NSLocalizedString(@"Apricot Turkey",nil);
    recipe10.prepTime = @"50 min";
    recipe10.image = @"Apricot_Turkey.png";
    recipe10.ingredients = [NSArray arrayWithObjects:NSLocalizedString(@"Apricot Turkey 1",nil), NSLocalizedString(@"Apricot Turkey 2",nil),NSLocalizedString(@"Apricot Turkey 3",nil),NSLocalizedString(@"Apricot Turkey 4",nil),NSLocalizedString(@"Apricot Turkey 5",nil),NSLocalizedString(@"Apricot Turkey 6",nil),NSLocalizedString(@"Apricot Turkey 7",nil),NSLocalizedString(@"Apricot Turkey 8",nil),NSLocalizedString(@"Apricot Turkey 9",nil),NSLocalizedString(@"Apricot Turkey 10",nil),nil];
    
    Recipe *recipe11 = [Recipe new];
    recipe11.name = NSLocalizedString(@"Basil Soup",nil);
    recipe11.prepTime = @"35 min";
    recipe11.image = @"tomato_basil_soup.png";
    recipe11.ingredients = [NSArray arrayWithObjects:NSLocalizedString(@"Basil Soup 1",nil), NSLocalizedString(@"Basil Soup 2",nil),NSLocalizedString(@"Basil Soup 3",nil),NSLocalizedString(@"Basil Soup 4",nil),NSLocalizedString(@"Basil Soup 5",nil),NSLocalizedString(@"Basil Soup 6",nil),NSLocalizedString(@"Basil Soup 7",nil),NSLocalizedString(@"Basil Soup 8",nil),NSLocalizedString(@"Basil Soup 9",nil),nil];
    
    Recipe *recipe12 = [Recipe new];
    recipe12.name = NSLocalizedString(@"Wine Beef",nil);
    recipe12.prepTime = @"2 hours";
    recipe12.image = @"red_wine_beef_stew.png";
    recipe12.ingredients = [NSArray arrayWithObjects:NSLocalizedString(@"Basil Soup 1",nil), NSLocalizedString(@"Basil Soup 2",nil),NSLocalizedString(@"Basil Soup 3",nil),NSLocalizedString(@"Basil Soup 4",nil),NSLocalizedString(@"Basil Soup 5",nil),NSLocalizedString(@"Basil Soup 6",nil),NSLocalizedString(@"Basil Soup 7",nil),NSLocalizedString(@"Basil Soup 8",nil),NSLocalizedString(@"Basil Soup 9",nil),nil];
    
    Recipe *recipe13 = [Recipe new];
    recipe13.name = NSLocalizedString(@"Lentil Quinoa",nil);
    recipe13.prepTime = @"45 min";
    recipe13.image = @"Lentil_Quinoa.png";
    recipe13.ingredients = [NSArray arrayWithObjects:NSLocalizedString(@"Lentil Quinoa 1",nil), NSLocalizedString(@"Lentil Quinoa 2",nil),NSLocalizedString(@"Lentil Quinoa 3",nil),NSLocalizedString(@"Lentil Quinoa 4",nil),NSLocalizedString(@"Lentil Quinoa 5",nil),nil];
    
    Recipe *recipe14 = [Recipe new];
    recipe14.name = NSLocalizedString(@"Italian Pasta",nil);
    recipe14.prepTime = @"20 min";
    recipe14.image = @"Italian_Pasta.png";
    recipe14.ingredients = [NSArray arrayWithObjects:NSLocalizedString(@"Italian Pasta 1",nil), NSLocalizedString(@"Italian Pasta 2",nil),NSLocalizedString(@"Italian Pasta 3",nil),NSLocalizedString(@"Italian Pasta 4",nil),NSLocalizedString(@"Italian Pasta 5",nil),NSLocalizedString(@"Italian Pasta 6",nil),NSLocalizedString(@"Italian Pasta 7",nil),NSLocalizedString(@"Italian Pasta 8",nil),NSLocalizedString(@"Italian Pasta 9",nil),NSLocalizedString(@"Italian Pasta 10",nil),NSLocalizedString(@"Italian Pasta 11",nil),NSLocalizedString(@"Italian Pasta 12",nil),NSLocalizedString(@"Italian Pasta 13",nil),nil];

    
    
    Recipe *recipe15 = [Recipe new];
    recipe15.name = NSLocalizedString(@"Vegetable Curry",nil);
    recipe15.prepTime = @"30 min";
    recipe15.image = @"vegetable_curry.jpg";
    recipe15.ingredients = [NSArray arrayWithObjects:NSLocalizedString(@"Vegetable Curry 1",nil), NSLocalizedString(@"Vegetable Curry 2",nil),NSLocalizedString(@"Vegetable Curry 3",nil),NSLocalizedString(@"Vegetable Curry 4",nil),NSLocalizedString(@"Vegetable Curry 5",nil),nil];
    
    Recipe *recipe16 = [Recipe new];
    recipe16.name = NSLocalizedString(@"Instant Noodle with Egg",nil);
    recipe16.prepTime = @"8 min";
    recipe16.image = @"instant_noodle_with_egg.jpg";
    recipe16.ingredients =[NSArray arrayWithObjects:NSLocalizedString(@"Instant Noodle 1",nil), NSLocalizedString(@"Instant Noodle 2",nil),nil];

    
    Recipe *recipe17 = [Recipe new];
    recipe17.name = NSLocalizedString(@"BBQ Noodle",nil);
    recipe17.prepTime = @"20 min";
    recipe17.image = @"noodle_with_bbq_pork.jpg";
    recipe17.ingredients = [NSArray arrayWithObjects:NSLocalizedString(@"BBQ Noodle 1",nil), NSLocalizedString(@"BBQ Noodle 2",nil),NSLocalizedString(@"BBQ Noodle 3",nil), nil];
    
    Recipe *recipe18 = [Recipe new];
    recipe18.name = NSLocalizedString(@"Japanese Noodle",nil);
    recipe18.prepTime = @"20 min";
    recipe18.image = @"japanese_noodle_with_pork.jpg";
    recipe18.ingredients = [NSArray arrayWithObjects:NSLocalizedString(@"Japanese Noodle 1",nil), NSLocalizedString(@"Japanese Noodle 2",nil),NSLocalizedString(@"Japanese Noodle 3",nil),NSLocalizedString(@"Japanese Noodle 4",nil), nil];
    



    
    recipes = [NSArray arrayWithObjects:recipe1, recipe2, recipe3, recipe4, recipe5, recipe6, recipe7, recipe8, recipe9, recipe10, recipe11, recipe12, recipe13, recipe14, recipe15, recipe16, recipe17, recipe18, nil];
    
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [recipes count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomTableCell";
    RecipeTableCell *cell = (RecipeTableCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[RecipeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Display recipe in the table cell
    Recipe *recipe = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        recipe = [searchResults objectAtIndex:indexPath.row];
    } else {
        recipe = [recipes objectAtIndex:indexPath.row];
    }
    
    cell.nameLabel.text = recipe.name;
    cell.thumbnailImageView.image = [UIImage imageNamed:recipe.image];
    cell.prepTimeLabel.text = recipe.prepTime;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
        NSIndexPath *indexPath = nil;
        Recipe *recipe = nil;
        
        if (self.searchDisplayController.active) {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            recipe = [searchResults objectAtIndex:indexPath.row];
        } else {
            indexPath = [self.tableView indexPathForSelectedRow];
            recipe = [recipes objectAtIndex:indexPath.row];
        }
        
        RecipeDetailViewController *destViewController = segue.destinationViewController;
        destViewController.recipe = recipe;
    }
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    searchResults = [recipes filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
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

@end
