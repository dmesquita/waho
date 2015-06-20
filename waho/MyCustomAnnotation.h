//
//  MyCustomAnnotation.h
//  waho
//
//  Created by Déborah Mesquita on 16/06/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapKit/MapKit.h"

@interface MyCustomAnnotation : NSObject <MKAnnotation>
@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (copy,nonatomic) NSString *title;
@property (nonatomic) int id_place;
@property (copy,nonatomic) NSString *type;

- (id)initWithTitle:(NSString *) newTitle Location:(CLLocationCoordinate2D)location Type:(NSString*)type;
- (MKAnnotationView *)annotationView;

@end
