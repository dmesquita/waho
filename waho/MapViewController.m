//
//  MapViewController.m
//  waho
//
//  Created by Déborah Mesquita on 16/06/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize activityLoadingMarkers;
@synthesize mapView;
@synthesize placesArray, favoritedPlaces, visitedPlaces, tableView;


- (void)viewDidLoad {
    tableView.delegate = self;
    tableView.dataSource = self;
    //[PFUser logOut];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"Helvetica" size:16], NSFontAttributeName,
                                [UIColor blackColor], NSForegroundColorAttributeName, nil];
    [_segmentedControlMap setTitleTextAttributes:attributes forState:UIControlStateSelected];
    [_segmentedControlMap setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    [super viewDidLoad];
    
    // --- To show custom annotations ---
    self.mapView.delegate = self;
    
    // --- Getting user's location ---
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    self.mapView.showsUserLocation=YES;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    CLLocation *location = [self.locationManager location];
    CLLocationCoordinate2D userCoordinate = [location coordinate];
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(userCoordinate, 15500, 15500);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    
    [self.mapView setRegion:adjustedRegion animated:YES];
    
    [activityLoadingMarkers startAnimating];
    
    
    // --- Loading markers ---
    PFQuery *query = [PFQuery queryWithClassName:@"Place"];
    //query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query findObjectsInBackgroundWithBlock:^(NSArray *places, NSError *error) {
        if (!error) {
            placesArray = places;
            [[PlacesFromParse sharedPlacesFromParse]setPlacesArray:places];
            CLLocationCoordinate2D annotationCoord;
            PFGeoPoint * point;
            for(int i = 0; i < [places count]; i++){
                point = places[i][@"location"];
                double lat = point.latitude;
                double lon = point.longitude;
                annotationCoord.latitude = lat;
                annotationCoord.longitude = lon;
                MyCustomAnnotation *annotationPointCustom = [[MyCustomAnnotation alloc] initWithTitle:places[i][@"name"] Location:annotationCoord Type:places[i][@"categoria"] ];
                annotationPointCustom.id_place = i;
                
                [mapView addAnnotation:annotationPointCustom];
            };[tableView reloadData];
            activityLoadingMarkers.hidesWhenStopped = true;
            [activityLoadingMarkers stopAnimating];
        } else {
            [self loadMarkersFail];
            NSLog(@"Erro ao carregar marcadores");
        }
    }];
     
    [self getFavoritedPlaces];
    [self getVisitedPlaces];
    
}


- (void) getFavoritedPlaces {
    favoritedPlaces = [[NSMutableArray alloc] init];
    if ([PFUser currentUser] != nil) {
        PFQuery *queryUser = [PFQuery queryWithClassName:@"Place"];
        [queryUser whereKey:@"favorites" equalTo:[[PFUser currentUser] objectId]];
        [queryUser findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                [[PlacesFromParse sharedPlacesFromParse]setFavoritedPlaces:objects];
                if([objects count] > 0){
                    NSLog(@"Lista de favoritos encontrada");                    
                    for (int i = 0; i < [objects count]; i++) {
                        NSLog(objects[i][@"name"]);
                        //int id_place = objects[i][@"id_place"];
                        [favoritedPlaces addObject:objects[i]];
                    };
                }else{
                    NSLog(@"Nenhum favorito encontrado ao procurar lista de favoritos");
                }
            } else {
                NSLog(@"Error: %@", error);
            }
        }];
    } else {
        NSLog(@"Usuario nao esta logado");
    }
    
}

- (void) getVisitedPlaces {
    visitedPlaces = [[NSMutableArray alloc] init];
    if ([PFUser currentUser] != nil) {
        PFQuery *queryUser = [PFQuery queryWithClassName:@"Place"];
        [queryUser whereKey:@"visited" equalTo:[[PFUser currentUser] objectId]];
        [queryUser findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                [[PlacesFromParse sharedPlacesFromParse]setVisitedPlaces:objects];
                if([objects count] > 0){
                    NSLog(@"Lista de visitados encontrada");
                    for (int i = 0; i < [objects count]; i++) {
                        NSLog(objects[i][@"name"]);
                        //int id_place = objects[i][@"id_place"];
                        [visitedPlaces addObject:objects[i]];
                    };
                }else{
                    NSLog(@"Nenhum local visitado encontrado ao procurar lista");
                }
            } else {
                NSLog(@"Error: %@", error);
            }
        }];
    } else {
        NSLog(@"Usuario nao esta logado");
    }
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if([annotation isKindOfClass:[MyCustomAnnotation class]]){
        MyCustomAnnotation *myLocation = (MyCustomAnnotation *)annotation;
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MyCustomAnnotation"];
        if(annotationView == nil){
            annotationView = myLocation.annotationView;            
        }else{
            annotationView.annotation = annotation;
        }
        return annotationView;
    }else{
        return nil;
    }
    
}

-(void)viewWillAppear:(BOOL)animated{

}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    EstablishmentViewController *establishmentVC = (EstablishmentViewController *)[storyboard instantiateViewControllerWithIdentifier:@"Establishment"];
    MyCustomAnnotation *annotation = (MyCustomAnnotation *)view.annotation;
    establishmentVC.place = placesArray[annotation.id_place];
    establishmentVC.favoritedPlaces = favoritedPlaces;
    establishmentVC.visitedPlaces = visitedPlaces;
    [self.navigationController pushViewController:establishmentVC animated:YES];
}

- (void) loadMarkersFail {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooooops!" message:@"Erro ao carregar locais" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (IBAction)valueChangedMap:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
            //map
        case 0:
            self.mapView.hidden = NO;
            self.listEstablishmentView.hidden = YES;
            break;
            
            //list establishment
        case 1:
            self.mapView.hidden = YES;
            self.listEstablishmentView.hidden = NO;
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return  [placesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"tablePeopleMapa";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UILabel *nomeLabel = (UILabel *)[cell viewWithTag:101];
    nomeLabel.text = [placesArray objectAtIndex:indexPath.row][@"name"];
    
    PFImageView *placeImageView = (PFImageView *)[cell viewWithTag:100];
    PFFile *imageFile = [placesArray objectAtIndex:indexPath.row][@"pictureSombra"];
    placeImageView.file = imageFile;
    [placeImageView loadInBackground];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pushFavorite2"]) {
        NSLog(@"preparou");
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        EstablishmentViewController *vc = [segue destinationViewController];
        vc.place = placesArray[(int) indexPath.row];
        vc.favoritedPlaces = favoritedPlaces;
        vc.visitedPlaces = visitedPlaces;
    }
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
