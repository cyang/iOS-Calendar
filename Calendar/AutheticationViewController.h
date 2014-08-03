//
//  AutheticationViewController.h
//  mxmum
//
//  Created by Christopher Yang on 7/29/14.
//  Copyright (c) 2014 mxmum. All rights reserved.
//

#import "ViewController.h"

@interface AutheticationViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *setEmailAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *createPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

- (IBAction)loginPressed:(id)sender;

- (IBAction)setEmailAndPassword:(id)sender;



@end
