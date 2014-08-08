//
//  ProfileViewController.h
//  Calendar
//
//  Created by Christopher Yang on 7/22/14.
//  Copyright (c) 2014 mxmum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ProfileViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (strong, nonatomic) IBOutlet UIImageView *imageView;


- (IBAction)selectPhoto:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
- (IBAction)confirm:(UIButton *)sender;
- (IBAction)logoutPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *categoryChosenLabel;

@end
