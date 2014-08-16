//
//  AddEventViewController.h
//  mxmum
//
//  Created by Christopher Yang on 8/14/14.
//  Copyright (c) 2014 mxmum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddEventViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextView *notesTextView;
@property (weak, nonatomic) IBOutlet UITextField *eventNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)selectPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *startDateButton;
@property (strong, nonatomic) IBOutlet UIButton *endsDateButton;
@end
