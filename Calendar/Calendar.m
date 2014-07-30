//
//  Calendar.m
//  Calendar
//
//  Created by Christopher Yang on 7/25/14.
//  Copyright (c) 2014 mxmum. All rights reserved.
//
#import "Calendar.h"


#pragma mark - Calendar
@implementation Calendar
float height;

- (NSUInteger) supportedInterfaceOrientations{
	return  UIInterfaceOrientationMaskPortrait;
}
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}


#pragma mark View Lifecycle
- (void) viewDidLoad{
	[super viewDidLoad];
    

	[self.monthView selectDate:[NSDate date]];
    CGRect myCalendar = self.monthView.frame;
    myCalendar.origin.y = 64.28;
    self.monthView.frame = myCalendar;
    height = CGRectGetHeight(myCalendar);
    
    CGRect myTable = self.tableView.frame;
    myTable.size.width += 16;
    myTable.origin.y = height + 64;
    myTable.origin.x = -15.5;
    self.tableView.frame = myTable;
    
}



#pragma mark MonthView Delegate & DataSource
- (NSArray*) calendarMonthView:(TKCalendarMonthView*)monthView marksFromDate:(NSDate*)startDate toDate:(NSDate*)lastDate{
	[self generateRandomDataForStartDate:startDate endDate:lastDate];
	return self.dataArray;
}
- (void) calendarMonthView:(TKCalendarMonthView*)monthView didSelectDate:(NSDate*)date{
	NSLog(@"Date Selected: %@",date);
	[self.tableView reloadData];
}
- (void) calendarMonthView:(TKCalendarMonthView*)mv monthDidChange:(NSDate*)d animated:(BOOL)animated{
	[super calendarMonthView:mv monthDidChange:d animated:animated];
	[self.tableView reloadData];
}


#pragma mark UITableView Delegate & DataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSArray *ar = self.dataDictionary[[self.monthView dateSelected]];
	if(ar == nil) return 0;
	return [ar count];
}
- (UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
	
    
	NSArray *ar = self.dataDictionary[[self.monthView dateSelected]];
	cell.textLabel.text = ar[indexPath.row];
	
    return cell;
	
}


- (void) generateRandomDataForStartDate:(NSDate*)start endDate:(NSDate*)end{
	// this function sets up dataArray & dataDictionary
	// dataArray: has boolean markers for each day to pass to the calendar view (via the delegate function)
	// dataDictionary: has items that are associated with date keys (for tableview)
	
	
	NSLog(@"Delegate Range: %@ %@ %@",start,end,@([start daysBetweenDate:end]));
	
	self.dataArray = [NSMutableArray array];
	self.dataDictionary = [NSMutableDictionary dictionary];
 
	
	NSDate *d = start;
	while(YES){
		NSInteger r = arc4random();
		if(r % 3==1){
			(self.dataDictionary)[d] = @[@" Item one",@" Item two"];
			[self.dataArray addObject:@YES];
			
		}else if(r%4==1){
			(self.dataDictionary)[d] = @[@" Item one"];
			[self.dataArray addObject:@YES];
			
		}else
			[self.dataArray addObject:@NO];
		
		
		NSDateComponents *info = [d dateComponentsWithTimeZone:self.monthView.timeZone];
		info.day++;
		d = [NSDate dateWithDateComponents:info];
		if([d compare:end]==NSOrderedDescending) break;
	}
	
}




@end
