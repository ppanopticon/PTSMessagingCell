//
//  ViewController.m
//  PTSMessagingCellDemo
//
//  Created by Ralph Gasser on 15.09.12.
//  Copyright (c) 2012 pontius software GmbH. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)awakeFromNib {
    
    _messages = [[NSArray alloc] initWithObjects:
              @"Hello, how are you.",
              @"I'm great, how are you?",
              @"I'm fine, thanks. Up for dinner tonight?",
              @"Glad to hear. No sorry, I have to work.",
              @"Oh that sucks. A pitty, well then - have a nice day.."
              @"Thanks! You too. Cuu soon.",
              nil];
    
    [super awakeFromNib];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*This method sets up the table-view.*/
    
    static NSString* cellIdentifier = @"messagingCell";
    
    PTSMessagingCell * cell = (PTSMessagingCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[PTSMessagingCell alloc] initMessagingCellWithReuseIdentifier:cellIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize messageSize = [PTSMessagingCell messageSize:[_messages objectAtIndex:indexPath.row]];
    return messageSize.height + 2*[PTSMessagingCell textMarginVertical] + 40.0f;
}

-(void)configureCell:(id)cell atIndexPath:(NSIndexPath *)indexPath {
    PTSMessagingCell* ccell = (PTSMessagingCell*)cell;
    
    if (indexPath.row % 2 == 0) {
        ccell.sent = YES;
        ccell.avatarImageView.image = [UIImage imageNamed:@"person1"];
    } else {
        ccell.sent = NO;
        ccell.avatarImageView.image = [UIImage imageNamed:@"person2"];
    }
    
    ccell.messageLabel.text = [_messages objectAtIndex:indexPath.row];
    ccell.timeLabel.text = @"2012-08-29";
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}



@end
