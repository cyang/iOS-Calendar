//
//  Profile.h
//  Calendar
//
//  Created by Christopher Yang on 7/22/14.
//  Copyright (c) 2014 mxmum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Profile : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (strong, nonatomic) IBOutlet UIImageView *imageView;


- (IBAction)selectPhoto:(UIButton *)sender;


@end
