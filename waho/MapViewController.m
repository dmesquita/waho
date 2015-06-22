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
@synthesize placesArray, favoritedPlaces, tableView;

- (void)viewDidLoad {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    tableView.delegate = self;
    tableView.dataSource = self;
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
    
    // --- Zooming into users region ---
    /**
    MKCoordinateRegion viewRegion;
    viewRegion.center = [location coordinate];
    viewRegion.span.latitudeDelta = 0.2;
    viewRegion.span.longitudeDelta = 0.2;
    **/
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
    
}


- (void) getFavoritedPlaces {
    favoritedPlaces = [[NSMutableArray alloc] init];
    if ([PFUser currentUser] != nil) {
        PFQuery *queryUser = [PFQuery queryWithClassName:@"Place"];
        [queryUser whereKey:@"favorites" equalTo:[[PFUser currentUser] objectId]];
        [queryUser findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    // --- To show the navbar tab
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    EstablishmentViewController *establishmentVC = (EstablishmentViewController *)[storyboard instantiateViewControllerWithIdentifier:@"Establishment"];
    MyCustomAnnotation *annotation = (MyCustomAnnotation *)view.annotation;
    establishmentVC.place = placesArray[annotation.id_place];
    establishmentVC.favoritedPlaces = favoritedPlaces;
    [self.navigationController pushViewController:establishmentVC animated:YES];
}

- (void) loadMarkersFail {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooooops!" message:@"Erro ao carregar locais" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{ NSLog(@"hdkjfhsdkjhfkjs");
    if(item.tag==1)
    {
        NSLog(@"hdkjfhsdkjhfkjs");
    }
    else
    {
        //your code
    }
}

- (IBAction)valueChangedMap:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
            //map
        case 0:
            [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            [self.navigationController.navigationBar setShadowImage:[UIImage new]];
            self.mapView.hidden = NO;
            self.listEstablishmentView.hidden = YES;
            break;
            
            //list establishment
        case 1:
            [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
            [self.navigationController.navigationBar setShadowImage:nil];
            
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
    
    //cell.textLabel.text = [placesArray objectAtIndex:indexPath.row][@"name"];
    UILabel *nomeLabel = (UILabel *)[cell viewWithTag:101];
    nomeLabel.text = [placesArray objectAtIndex:indexPath.row][@"name"];
    //cell.textLabel.text = [placesArray objectAtIndex:indexPath.row][@"picture1"];
    //cell.imageView.image = [UIImage imageNamed:@"pin"];
    
    PFImageView *placeImageView = (PFImageView *)[cell viewWithTag:100];
    PFFile *imageFile = [placesArray objectAtIndex:indexPath.row][@"picture1"];
    placeImageView.file = imageFile;
    [placeImageView loadInBackground];
    
    return cell;
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"pushFavorite2"]) {
//        NSLog(@"preparou");
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
//        // NSLog(%i, indexPath.row);
//        // Get destination view
//        EstablishmentViewController *vc = [segue destinationViewController];
//        
//        // Get button tag number (or do whatever you need to do here, based on your object
//        vc.place = placesArray[(int) indexPath.row];
//        
//        // Pass the information to your destination view
//        //[vc setSelectedButton:tagIndex];
//    }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
