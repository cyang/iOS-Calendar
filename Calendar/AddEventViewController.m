//
//  AddEventViewController.m
//  mxmum
//
//  Created by Christopher Yang on 8/14/14.
//  Copyright (c) 2014 mxmum. All rights reserved.
//

#import "AddEventViewController.h"

@interface AddEventViewController ()

@end

@implementation AddEventViewController

NSString *dateString = @"";

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
    self.notesTextView.layer.borderWidth = 2.0f;
    self.notesTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    [self delegateTextField];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterFullStyle timeStyle:NSDateFormatterShortStyle];
    
    [self.startDateButton setTitle:dateString forState:UIControlStateNormal];
    [self.endsDateButton setTitle:dateString forState:UIControlStateNormal];

    
    NSDate *now = [NSDate date];
    [_datePicker setDate:now animated:YES];
    }

- (void)delegateTextField{
    self.eventNameTextField.delegate = self;
    self.locationTextField.delegate = self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.notesTextView resignFirstResponder];
    [self.eventNameTextField resignFirstResponder];
    [self.locationTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField) {
        [textField resignFirstResponder];
    }
    return NO;
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

- (IBAction)selectPressed:(id)sender {
    NSDate *selected = [_datePicker date];
    dateString = [NSDateFormatter localizedStringFromDate:selected dateStyle:NSDateFormatterFullStyle timeStyle:NSDateFormatterShortStyle];
    NSLog(@"%@", selected);

    [self.startDateButton setTitle:dateString forState:UIControlStateSelected];


    
}
@end
