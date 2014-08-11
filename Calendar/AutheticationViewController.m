//
//  AutheticationViewController.m
//  mxmum
//
//  Created by Christopher Yang on 7/29/14.
//  Copyright (c) 2014 mxmum. All rights reserved.
//

#import "AutheticationViewController.h"
#import "CalendarViewController.h"
#import "ViewController.h"
#import "ProfileViewController.h"

@interface AutheticationViewController ()

@end

@implementation AutheticationViewController

NSIndexPath* checkedIndexPath;
NSArray *categories;
PFUser *newUser;

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
    newUser = [PFUser user];
    self.cellText = @"";
    
    categories = [NSArray arrayWithObjects:@"Model", @"Photographer", @"Artist", @"Intern", @"World", nil];
    [self delegateTextField];
}

- (void)delegateTextField{
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.nameTextField.delegate = self;
    self.confirmPasswordTextField.delegate = self;
    self.loginEmailTextField.delegate = self;
    self.loginPasswordTextField.delegate = self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.nameTextField resignFirstResponder];
    [self.confirmPasswordTextField resignFirstResponder];
    [self.loginEmailTextField resignFirstResponder];
    [self.loginPasswordTextField resignFirstResponder];
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


- (IBAction)setEmailAndPassword:(id)sender {
    [self checkFieldsComplete];
}

-(void)checkFieldsComplete{
    if ([_emailTextField.text isEqualToString:@""] || [_passwordTextField.text isEqualToString:@""] || [_confirmPasswordTextField.text isEqualToString:@""] || [_nameTextField.text isEqualToString:@""] || [self.cellText isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"You must complete all fields" delegate:nil cancelButtonTitle:nil     otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else {
        [self checkPasswordsMatched];
    }
}

-(void)checkPasswordsMatched {
    if (![_passwordTextField.text isEqualToString:_confirmPasswordTextField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your entered passwords do not match" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else {
        [self registerNewUser];
    }
}


- (void) registerNewUser {
    newUser.username = _emailTextField.text;
    newUser.email = _emailTextField.text;
    newUser.password = _passwordTextField.text;
    [newUser setObject:_nameTextField.text forKey:@"fullName"];
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done Setting Email and password" message:@"Logged in!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            [PFUser logInWithUsernameInBackground:_emailTextField.text password:_passwordTextField.text block:^(PFUser *user, NSError *error) {
                CalendarViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Calendar"];
                [self presentViewController:vc animated:YES completion:nil];
            }];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Invalid email or the email is already in use" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
    }];
}

- (IBAction)loginPressed:(id)sender {
    [PFUser logInWithUsernameInBackground:_loginEmailTextField.text password:_loginPasswordTextField.text block:^(PFUser *user, NSError *error) {
        if (!error) {
            [self performSegueWithIdentifier:@"login" sender:self];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"You've logged in!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Mismatch" message:@"Email or password is incorrect" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
    }];
}

#pragma Table View Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [categories objectAtIndex:indexPath.row];
    if([self.checkedIndexPath isEqual:indexPath])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Uncheck the previous checked row
    if(self.checkedIndexPath)
    {
        UITableViewCell* uncheckCell = [tableView
                                        cellForRowAtIndexPath:self.checkedIndexPath];
        uncheckCell.accessoryType = UITableViewCellAccessoryNone;
    }
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.checkedIndexPath = indexPath;
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    self.cellText = selectedCell.textLabel.text;
    [newUser setObject:self.cellText forKey:@"categoryChosen"];
    self.cellText = [newUser objectForKey:@"categoryChosen"];
}

@end