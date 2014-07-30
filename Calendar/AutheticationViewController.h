//
//  AutheticationViewController.h
//  mxmum
//
//  Created by Christopher Yang on 7/29/14.
//  Copyright (c) 2014 mxmum. All rights reserved.
//

#import "ViewController.h"

@interface AutheticationViewController : ViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *setEmailAddressTextField;
@property (strong, nonatomic) IBOutlet UITextField *setPasswordTextField;

- (IBAction)loginPressed:(id)sender;

- (IBAction)setEmailAndPassword:(id)sender;



@end
