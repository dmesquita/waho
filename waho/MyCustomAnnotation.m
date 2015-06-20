//
//  MyCustomAnnotation.m
//  waho
//
//  Created by Déborah Mesquita on 16/06/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "MyCustomAnnotation.h"

@implementation MyCustomAnnotation 

- (id)initWithTitle:(NSString *)newTitle Location:(CLLocationCoordinate2D)location Type:(NSString *)type{
    self = [super init];
    if(self){
        _title = newTitle;
        _coordinate = location;
        _type = type;
    }
    return self;
}

- (MKAnnotationView *)annotationView{
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"MyCustomAnnotation"];
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    if([self.type isEqual: @"Restaurante"]){
        annotationView.image = [UIImage imageNamed:@"restaurante"];
    }else if([self.type isEqual: @"Feira"]){
        annotationView.image = [UIImage imageNamed:@"feira"];
    }else if([self.type isEqual: @"Mercado"]){
        annotationView.image = [UIImage imageNamed:@"artesanato"];
    }
    
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;
};


@end
