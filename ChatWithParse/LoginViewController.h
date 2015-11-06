//
//  ViewController.h
//  ChatWithParse
//
//  Created by Aswani Nerella on 11/5/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)Login:(id)sender;
- (IBAction)Signup:(id)sender;

@end

