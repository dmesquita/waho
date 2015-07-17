//
//  PlacesFromParse.m
//  waho
//
//  Created by Déborah Mesquita on 16/07/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "PlacesFromParse.h"

@implementation PlacesFromParse

@synthesize placesArray, favoritedPlaces, visitedPlaces;

#pragma mark Singleton Methods

+ (id)sharedPlacesFromParse {
    static PlacesFromParse *sharedPlacesFromParse = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPlacesFromParse= [[self alloc] init];
    });
    return sharedPlacesFromParse;
}

- (id)init {
    if (self = [super init]) {
        self.placesArray = nil;
        self.favoritedPlaces = nil;
        self.visitedPlaces = nil;
    }
    return self;
}

-(id)initWithName:(NSArray *)placesArray_ favoritedPlaces:(NSMutableArray *)favoritedPlaces_ visitedPlaces:(NSMutableArray *)visitedPlaces_
{
    self = [super init];
    if (self) {
        self.placesArray = placesArray_;
        self.favoritedPlaces = favoritedPlaces_;
        self.visitedPlaces = visitedPlaces_;
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
