//
//  ViewController.m
//  ChatWithParse
//
//  Created by Aswani Nerella on 11/5/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "ChatViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Login:(id)sender {
    // try to login
    [PFUser logInWithUsernameInBackground:self.emailText.text password:self.password.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                            ChatViewController *cvc = [storyboard instantiateViewControllerWithIdentifier:@"ChatViewController"];
                                            [cvc setModalPresentationStyle:UIModalPresentationFullScreen];
                                            [self presentViewController:cvc animated:YES completion:nil];
                                        } else {
                                            // The login failed. Check error to see why.
                                            NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
                                            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"SignUp Error!"
                                                                                                           message:errorString
                                                                                                    preferredStyle:UIAlertControllerStyleAlert];
                                            
                                            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                                                  handler:^(UIAlertAction * action) {}];
                                            
                                            [alert addAction:defaultAction];
                                            [self presentViewController:alert animated:YES completion:nil];
                                        }
                                    }];
    
}

- (IBAction)Signup:(id)sender {
    PFUser *user = [PFUser user];
    user.password = self.password.text;
    user.email = self.emailText.text;
    user.username = user.email;
    
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {   // Hooray! Let them use the app now.
        } else {   NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"SignUp Error!"
                                                                           message:errorString
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}
@end
