//
//  MapAndListContainerViewController.m
//  waho
//
//  Created by Déborah Mesquita on 16/07/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "MapAndListContainerViewController.h"

@interface MapAndListContainerViewController ()

@end

@implementation MapAndListContainerViewController

@synthesize segmentControl, containerMap, containerList, placesArray, favoritedPlaces, visitedPlaces ,activityLoadingMarkers;

- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
    case 0 :
            containerMap.hidden = false;
            containerList.hidden = true;
            break;
    case 1:
            containerMap.hidden = true;
            containerList.hidden = false;
            break;
            
    default:
            break;
    }
}

- (void)viewDidLoad {
    //NSLog(@"children : %@", self.childViewControllers);
    //[[PlacesFromParse alloc] init];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"Helvetica" size:16], NSFontAttributeName,
                                [UIColor blackColor], NSForegroundColorAttributeName, nil];
    [segmentControl setTitleTextAttributes:attributes forState:UIControlStateSelected];
    [segmentControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    [super viewDidLoad];
    [activityLoadingMarkers startAnimating];
    
    // --- Loading markers ---
    PFQuery *query = [PFQuery queryWithClassName:@"Place"];
    //query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query findObjectsInBackgroundWithBlock:^(NSArray *places, NSError *error) {
        if (!error) {
            placesArray = places;
            [[PlacesFromParse sharedPlacesFromParse]setPlacesArray:places];
            NSLog(@"DEIXOU MORRER FLORES QUE PLANTEI NO JARDIM DO NOSSO AMOR");
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
                if([objects count] > 0){
                    NSLog(@"Lista de favoritos encontrada");
                    [[PlacesFromParse sharedPlacesFromParse]setFavoritedPlaces:objects];
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
                if([objects count] > 0){
                    [[PlacesFromParse sharedPlacesFromParse]setVisitedPlaces:objects];
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

- (void) loadMarkersFail {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooooops!" message:@"Erro ao carregar locais" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void)viewDidAppear:(BOOL)animated{
    containerMap.hidden = false;
    containerList.hidden = true;
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
