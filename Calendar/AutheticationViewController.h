//
//  AutheticationViewController.h
//  mxmum
//
//  Created by Christopher Yang on 7/29/14.
//  Copyright (c) 2014 mxmum. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface AutheticationViewController : UIViewController <UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

@property (weak, nonatomic) IBOutlet UITextField *loginEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *loginPasswordTextField;

@property (nonatomic, retain) NSIndexPath* checkedIndexPath;


@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)loginPressed:(id)sender;


- (IBAction)setEmailAndPassword:(id)sender;



@end
