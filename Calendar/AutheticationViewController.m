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
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
    
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.nameTextField.delegate = self;
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
    [self.nameTextField resignFirstResponder];
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


- (IBAction)setEmailAndPassword:(id)sender {
    [self checkFieldsComplete];
}

-(void)checkFieldsComplete{
    if ([_emailTextField.text isEqualToString:@""] || [_passwordTextField.text isEqualToString:@""] || [_confirmPasswordTextField.text isEqualToString:@""] || [_nameTextField.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"You must complete all fields" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else {
        [self checkPasswordsMatched];
    }
}

-(void)checkPasswordsMatched {
    if (![_passwordTextField.text isEqualToString:_confirmPasswordTextField.text]) {
        NSLog(@"Passwords don't match");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your entered passwords do not match" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        
        [alert show];
        
        /*
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
         
         */
        
    }
    else {
        NSLog(@"Passwords match");
        [self registerNewUser];

    }
}

- (void) registerNewUser {
    PFUser *newUser = [PFUser user];
    newUser.username = _emailTextField.text;
    newUser.email = _emailTextField.text;
    newUser.password = _passwordTextField.text;
    
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Registration success");
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done Setting Email and Password" message:@"Completed" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            
            AutheticationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"2"];
            [self presentViewController:vc animated:YES completion:nil];
        }
        else {
            NSLog(@"Error in registering");
        }
    }];

}


- (IBAction)loginPressed:(id)sender {
    BOOL fileExist = [[NSFileManager defaultManager]fileExistsAtPath:fullPath];
    if (!fileExist) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Haven't set email and passwod" message:@"Please set email and password" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else
    {
        fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:fullPath];
        NSString *stringFromFile = [NSString stringWithContentsOfFile:fullPath encoding:NSASCIIStringEncoding error:nil];
        
        const char *charsFromFile = [stringFromFile UTF8String];
        
        NSString *emailFromFile = [[NSString alloc]init];
        NSString *passwordFromFile = [[NSString alloc]init];
        
        int count = 0;
        for (int i = 0; i < strlen(charsFromFile); i++) {
            if (charsFromFile[i]=='\n') {
                ++count;
            }
            else if(count == 0) // append characters to usernamefromfile
            {
                emailFromFile = [emailFromFile stringByAppendingString:[NSString stringWithFormat:@"%c", charsFromFile[i]]];
            }
            else    // append characters to passwordfromfile
            {
                passwordFromFile = [passwordFromFile stringByAppendingString:[NSString stringWithFormat:@"%c", charsFromFile[i]]];
            }
        }
        
        if ([emailFromFile isEqualToString:self.emailTextField.text] && [passwordFromFile isEqualToString:self.passwordTextField.text]) {
            CalendarViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"1"];
            [self presentViewController:vc animated:YES completion:nil];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"You've logged in!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Mismatch" message:@"Email or password is incorrect" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
    }
}


@end