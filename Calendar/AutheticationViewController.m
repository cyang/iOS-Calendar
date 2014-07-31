//
//  AutheticationViewController.m
//  mxmum
//
//  Created by Christopher Yang on 7/29/14.
//  Copyright (c) 2014 mxmum. All rights reserved.
//

#import "AutheticationViewController.h"

@interface AutheticationViewController ()
{
    NSFileManager* fileManager;
    NSString* fullPath;
    NSFileHandle* fileHandle;
}

@end

@implementation AutheticationViewController




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
    
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.setEmailAddressTextField.delegate = self;
    self.nameTextField.delegate = self;
    self.createPasswordTextField.delegate = self;
    self.confirmPasswordTextField.delegate = self;
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [paths objectAtIndex:0];
    
    fileManager = [NSFileManager defaultManager];
    fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:[filePath stringByAppendingPathComponent:@"Key.txt"]];
    
    
    [fileManager changeCurrentDirectoryPath:filePath];
    fullPath = [NSString stringWithFormat:@"%@", [filePath stringByAppendingPathComponent:@"Key.txt"]];
     
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.setEmailAddressTextField resignFirstResponder];
    [self.nameTextField resignFirstResponder];
    [self.createPasswordTextField resignFirstResponder];
    [self.confirmPasswordTextField resignFirstResponder];
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


- (IBAction)loginPressed:(id)sender {
}

- (IBAction)setEmailAndPassword:(id)sender {
    BOOL fileExist = [[NSFileManager defaultManager]fileExistsAtPath:fullPath];
    if (fileExist) {
        [fileManager createFileAtPath:fullPath contents:nil attributes:nil];
    }
    
    NSString *emailAndPasswordString = [NSString stringWithFormat:@"%@\n%@", self.setEmailAddressTextField.text, self.confirmPasswordTextField.text];
    fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:fullPath];
    NSData *data;
    const char *bytesOfEmailAndPassword = [emailAndPasswordString UTF8String];
    data = [NSData dataWithBytes:bytesOfEmailAndPassword length:strlen(bytesOfEmailAndPassword)];
    [data writeToFile:fullPath atomically:YES];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done Setting Email and Password" message:@"Completed" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    
}
    
@end