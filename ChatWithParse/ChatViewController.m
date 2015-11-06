//
//  ChatViewController.m
//  ChatWithParse
//
//  Created by Aswani Nerella on 11/5/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

#import <Parse/Parse.h>
#import "ChatViewController.h"
#import "LoginViewController.h"
#import "MessageTableViewCell.h"

@interface ChatViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *recievedMessages;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.title = @"Chats";
//    self.navigationItem.title = @"Chats";
    self.recievedMessages = [NSMutableArray array];
    self.chats.dataSource = self;
    self.chats.delegate = self;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector: @selector(onTimer) userInfo:nil repeats:YES];
    

}
- (void) onTimer{
    PFQuery *query = [PFQuery queryWithClassName:@"Message"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            self.recievedMessages = [objects mutableCopy];
            [self.chats reloadData];
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTableViewCell *mtvc = [self.chats dequeueReusableCellWithIdentifier:@"messageCell"];
    mtvc.messageBody.text = [self.recievedMessages[indexPath.row] objectId];
    return mtvc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sendMessage:(id)sender {
    PFObject *message = [PFObject objectWithClassName:@"Message"];
    message[@"text"] = self.chatText.text;
    [message saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"sent message %@", message);
            // The object has been saved.
        } else {
            // There was a problem, check error.description
        }
    }];
}
@end
