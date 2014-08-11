//
//  SearchViewController.m
//  mxmum
//
//  Created by Christopher Yang on 7/30/14.
//  Copyright (c) 2014 mxmum. All rights reserved.
//

#import "SearchViewController.h"
#import <Parse/Parse.h>
#import "AutheticationViewController.h"

@interface SearchViewController ()

@property (strong, nonatomic) NSMutableArray *array;
@property (strong, nonatomic) NSArray *searchResults;



@end

@implementation SearchViewController



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
    
    
    self.array = [[NSMutableArray alloc] init];
    

    
    self.searchResults = [[NSArray alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return  self.searchResults.count;
    }
    else
    {
        //_tableView.hidden = YES;

        return [self.array count];
    }
    
    //return [self.array count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    }
    
    //cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    return  cell;
}

#pragma Search Methods

- (void) filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", searchText];
    self.searchResults = [self.array filteredArrayUsingPredicate:predicate];

}

- (BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}





@end









