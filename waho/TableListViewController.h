//
//  TableListViewController.h
//  waho
//
//  Created by Déborah Mesquita on 16/07/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "ParseUI/ParseUI.h"

@interface TableListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic) NSArray *placesArray;

@end
