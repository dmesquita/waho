//
//  MapViewController.h
//  waho
//
//  Created by Miguel Araújo on 6/15/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface MapViewController : UIViewController <MKMapViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) MKPointAnnotation * annotation;

@end
