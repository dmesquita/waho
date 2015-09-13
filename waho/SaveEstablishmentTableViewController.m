//
//  SaveEstablishmentTableViewController.m
//  waho
//
//  Created by José Luiz Correia Neto on 15/06/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "SaveEstablishmentTableViewController.h"

@interface SaveEstablishmentTableViewController ()

@end

@implementation SaveEstablishmentTableViewController {
    
    NSMutableArray *savedEstablishments;

}

@synthesize tableView, favoritePlaces, visitedPlaces, favoriteImages;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    savedEstablishments = [[NSMutableArray alloc] init];
    favoriteImages = [[NSMutableArray alloc] init];
    favoritePlaces = [[PlacesFromParse sharedPlacesFromParse]favoritedPlaces];
    for (int i = 0; i < [favoritePlaces count]; i++){
        NSString *nome = favoritePlaces[i][@"name"];
        [savedEstablishments addObject:nome];
        PFFile *imagem = favoritePlaces[i][@"pictureSalvos"];
        [favoriteImages addObject:imagem];
    };
    [self.tableView reloadData];
    
    //Get visited Places
    visitedPlaces = [[PlacesFromParse sharedPlacesFromParse]visitedPlaces];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pushFavorite"]) {
        NSLog(@"preparou");
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        // NSLog(%i, indexPath.row);
        // Get destination view
        EstablishmentViewController *vc = [segue destinationViewController];
        
        // Get button tag number (or do whatever you need to do here, based on your object
        vc.place = favoritePlaces[(int) indexPath.row];
        vc.favoritedPlaces = favoritePlaces;
        vc.visitedPlaces = visitedPlaces;
        
        // Pass the information to your destination view
        //[vc setSelectedButton:tagIndex];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return  [savedEstablishments count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SavedEstablishmentCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    //cell.textLabel.text = [savedEstablishments objectAtIndex:indexPath.row];
    //cell.imageView.image = [UIImage imageNamed:@"pin"];
    
    PFImageView *placeImageView = (PFImageView *)[cell viewWithTag:100];
    
    UILabel *nomeLabel = (UILabel *)[cell viewWithTag:102];
    nomeLabel.text = [savedEstablishments objectAtIndex:indexPath.row];
    
    PFFile *imageFile = [favoriteImages objectAtIndex:indexPath.row];
    placeImageView.file = imageFile;
    [placeImageView loadInBackground];
    UIImageView *imgCategory = (UIImageView *)[cell viewWithTag:103];
    
    if([[favoritePlaces objectAtIndex:indexPath.row][@"categoria"]  isEqual: @"Feira"]){
        imgCategory.image = [UIImage imageNamed:@"icone feira escuro"];
    }else if([[self.favoritePlaces objectAtIndex:indexPath.row][@"categoria"]  isEqual: @"Mercado"]){
        imgCategory.image= [UIImage imageNamed:@"icone artesanato escuro"];
    }else if([[self.favoritePlaces objectAtIndex:indexPath.row][@"categoria"]  isEqual: @"Restaurante"]){
        imgCategory.image = [UIImage imageNamed:@"icone restaurante escuro"];
    }
    
    return cell;
}

@end
