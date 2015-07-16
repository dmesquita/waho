//
//  MapAndListContainerViewController.m
//  waho
//
//  Created by Déborah Mesquita on 16/07/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "MapAndListContainerViewController.h"

@interface MapAndListContainerViewController ()

@end

@implementation MapAndListContainerViewController

@synthesize segmentControl, containerMap, containerList, placesArray, activityLoadingMarkers;

- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
    case 0 :
            containerMap.hidden = false;
            containerList.hidden = true;
            break;
    case 1:
            containerMap.hidden = true;
            containerList.hidden = false;
            break;
            
    default:
            break;
    }
}

- (void)viewDidLoad {
    //NSLog(@"children : %@", self.childViewControllers);
    MapViewController *mapView = [self.childViewControllers objectAtIndex:0];
    TableListViewController *tableView = [self.childViewControllers objectAtIndex:1];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"Helvetica" size:16], NSFontAttributeName,
                                [UIColor blackColor], NSForegroundColorAttributeName, nil];
    [segmentControl setTitleTextAttributes:attributes forState:UIControlStateSelected];
    [segmentControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    [super viewDidLoad];
    [activityLoadingMarkers startAnimating];
    
    // --- Loading markers ---
    PFQuery *query = [PFQuery queryWithClassName:@"Place"];
    //query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query findObjectsInBackgroundWithBlock:^(NSArray *places, NSError *error) {
        if (!error) {
            placesArray = places;
            CLLocationCoordinate2D annotationCoord;
            PFGeoPoint * point;
            tableView.placesArray = placesArray;
            activityLoadingMarkers.hidesWhenStopped = true;
            [activityLoadingMarkers stopAnimating];
        } else {
            [self loadMarkersFail];
            NSLog(@"Erro ao carregar marcadores");
        }
    }];
}

- (void) loadMarkersFail {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooooops!" message:@"Erro ao carregar locais" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void)viewDidAppear:(BOOL)animated{
    containerMap.hidden = false;
    containerList.hidden = true;
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

@end
