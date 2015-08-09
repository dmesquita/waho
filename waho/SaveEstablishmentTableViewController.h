//
//  SaveEstablishmentTableViewController.h
//  waho
//
//  Created by José Luiz Correia Neto on 15/06/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "ParseUI/ParseUI.h"
#import "MapViewController.h"
#import "EstablishmentViewController.h"
#import "PlacesFromParse.h"
#import "MyFavViewCell.h"

@interface SaveEstablishmentTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *favoritePlaces;
@property (nonatomic) NSMutableArray *favoriteImages;
@property (nonatomic) NSMutableArray *visitedPlaces;

@end
