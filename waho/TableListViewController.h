//
//  TableListViewController.h
//  waho
//
//  Created by Déborah Mesquita on 16/07/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "PlacesFromParse.h"
#import "ListViewTableViewCell.h"
#import "EstablishmentViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface TableListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property(nonatomic) NSArray *placesArray;
@property(nonatomic) NSArray *items;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTableWidth;

@end
