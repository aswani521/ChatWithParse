//
//  ChatViewController.h
//  ChatWithParse
//
//  Created by Aswani Nerella on 11/5/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *chatText;
- (IBAction)sendMessage:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *chats;

@end
