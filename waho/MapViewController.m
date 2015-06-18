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
@synthesize placesArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //To show custom annotations
    self.mapView.delegate = self;
    
    //Getting user's location
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self ];
    self.mapView.showsUserLocation=YES;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    CLLocation *location = [self.locationManager location];
    CLLocationCoordinate2D userCoordinate = [location coordinate];
    /**
    MKCoordinateRegion viewRegion;
    viewRegion.center = [location coordinate];
    viewRegion.span.latitudeDelta = 0.2;
    viewRegion.span.longitudeDelta = 0.2;
    **/
//    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(userCoordinate, 500, 500);
//    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
//    
//    [self.mapView setRegion:adjustedRegion animated:YES];
    
    [activityLoadingMarkers startAnimating];
    
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
                MyCustomAnnotation *annotationPointCustom = [[MyCustomAnnotation alloc] initWithTitle:places[i][@"name"] Location:annotationCoord];
                annotationPointCustom.id_place = i;
                [mapView addAnnotation:annotationPointCustom];
            };
            activityLoadingMarkers.hidesWhenStopped = true;
            [activityLoadingMarkers stopAnimating];
        } else {
            NSLog(@"Deu erro");
        }
    }];
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

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    //launch a new view upon touching the disclosure indicator
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    EstablishmentViewController *tvc = (EstablishmentViewController *)[storyboard instantiateViewControllerWithIdentifier:@"Establishment"];
    MyCustomAnnotation *ann = (MyCustomAnnotation *)view.annotation;
    tvc.lbName = placesArray[ann.id_place][@"name"];
    tvc.lbAbout = placesArray[ann.id_place][@"about"];NSLog(placesArray[ann.id_place][@"objectId"]);
    [self.navigationController pushViewController:tvc animated:YES];
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
