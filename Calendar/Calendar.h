//
//  Calendar.h
//  Calendar
//
//  Created by Christopher Yang on 7/25/14.
//  Copyright (c) 2014 mxmum. All rights reserved.
//

#import <TapkuLibrary/TapkuLibrary.h>
@import UIKit;

#pragma mark - CalendarMonthViewController
@interface Calendar : TKCalendarMonthTableViewController

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableDictionary *dataDictionary;




- (void) generateRandomDataForStartDate:(NSDate*)start endDate:(NSDate*)end;

@end
