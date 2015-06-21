//
//  SaveEstablishmentTableViewController.h
//  waho
//
//  Created by José Luiz Correia Neto on 15/06/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

@interface SaveEstablishmentTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityLoadingFavs;

@end
