//
//  MapViewController.h
//  waho
//
//  Created by Déborah Mesquita on 16/06/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "MapKit/MapKit.h"
#import "Parse/Parse.h"
#import "MyCustomAnnotation.h"
#import "EstablishmentViewController.h"
#import "PlacesFromParse.h"

@interface MapViewController : UIViewController <MKMapViewDelegate,UITabBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic) NSArray *placesArray;
@property(nonatomic) NSMutableArray *favoritedPlaces;
@property(nonatomic) NSMutableArray *visitedPlaces;
@property(nonatomic) BOOL userLocationShown ; // Check if already loaded the location
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityLoadingMarkers;
@property (weak, nonatomic) IBOutlet UITableView *listEstablishmentView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControlMap;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void) getFavoritedPlaces;

@end
