//
//  ViewController.h
//  PTSMessagingCellDemo
//
//  Created by Ralph Gasser on 15.09.12.
//  Copyright (c) 2012 pontius software GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTSMessagingCell.h"

@interface ViewController : UIViewController {
    UITableView * tableView;
    
    NSArray * messages;
}

@property (nonatomic) IBOutlet UITableView * tableView;

@property (nonatomic) NSArray * messages;

@end
