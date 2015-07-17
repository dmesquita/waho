//
//  PlacesFromParse.h
//  waho
//
//  Created by Déborah Mesquita on 16/07/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlacesFromParse : NSObject {
    NSArray *placesArray;
    NSMutableArray *favoritedPlaces;
    NSMutableArray *visitedPlaces;
}

@property(nonatomic) NSArray *placesArray;
@property(nonatomic) NSMutableArray *favoritedPlaces;
@property(nonatomic) NSMutableArray *visitedPlaces;

+ (id)sharedPlacesFromParse;


@end
