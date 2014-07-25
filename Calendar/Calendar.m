//
//  Calendar.m
//  Calendar
//
//  Created by Christopher Yang on 7/25/14.
//  Copyright (c) 2014 mxmum. All rights reserved.
//

#import "Calendar.h"
#import "TapkuLibrary/TapkuLibrary.h"

@interface Calendar ()

@end

@implementation Calendar

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
    TKCalendarMonthView *calendar1=[[TKCalendarMonthView alloc] init];
    //calendar1.delegate = self;
    //calendar1.dataSource = self;
    [calendar1 selectDate:[NSDate date]];
    [self.view addSubview:calendar1];

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


@end
