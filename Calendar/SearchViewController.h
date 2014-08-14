//
//  SearchViewController.h
//  mxmum
//
//  Created by Christopher Yang on 7/30/14.
//  Copyright (c) 2014 mxmum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *array;
@property (strong, nonatomic) NSArray *searchResults;

@end
