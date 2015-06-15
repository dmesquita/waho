//
//  MapViewController.m
//  waho
//
//  Created by Miguel Araújo on 6/15/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    _annotation = [[MKPointAnnotation alloc] init];
    _mapView.delegate = self;
    _searchBar.delegate = self;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [_searchBar resignFirstResponder];
    
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:_searchBar.text completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark * placemark = [placemarks objectAtIndex:0];
        
        MKCoordinateRegion region;
        CLLocationCoordinate2D novaLocalizacao = [placemark.location coordinate];
        
        [_mapView removeAnnotation:_annotation];
        [_annotation setCoordinate:novaLocalizacao];
        [_annotation setTitle:_searchBar.text];
        [_mapView addAnnotation:_annotation];
        
        MKCoordinateSpan span;
        span.latitudeDelta = 1.0;
        span.longitudeDelta = 1.0;
        
        region.span = span;
        region.center = novaLocalizacao;
        
        [_mapView setRegion:region animated:YES];
        [_mapView regionThatFits:region];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
