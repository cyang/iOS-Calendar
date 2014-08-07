//
//  ProfileViewController.m
//  Calendar
//
//  Created by Christopher Yang on 7/22/14.
//  Copyright (c) 2014 mxmum. All rights reserved.
//

#import "ProfileViewController.h"
#import "AutheticationViewController.h"
#import "AutheticationViewController.m"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

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

- (IBAction)selectPhoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)confirm:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Saved changes" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    
    [alert show];
}

- (IBAction)logoutPressed:(id)sender {
    [PFUser logOut];
    AutheticationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"2"];
    [self presentViewController:vc animated:YES completion:nil];
    
}
@end
