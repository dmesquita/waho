//
//  MapViewController.h
//  waho
//
//  Created by Déborah Mesquita on 16/06/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "Parse/Parse.h"
#import "MyCustomAnnotation.h"

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic) NSArray *placesArray;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityLoadingMarkers;

@end
