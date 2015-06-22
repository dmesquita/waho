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

@synthesize activityLoadingFavs, tableView, favoritePlaces, favoriteImages;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [activityLoadingFavs startAnimating];
    savedEstablishments = [[NSMutableArray alloc] init];
    favoriteImages = [[NSMutableArray alloc] init];
    if ([PFUser currentUser] != nil) {
    PFQuery *queryUser = [PFQuery queryWithClassName:@"Place"];
    [queryUser whereKey:@"favorites" equalTo:[[PFUser currentUser] objectId]];
    [queryUser findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            favoritePlaces = objects;
            if([objects count] > 0){
                NSLog(@"Está na lista de favoritos -------------------------------------");
                for (int i = 0; i < [objects count]; i++){
                    NSString *nome = objects[i][@"name"];
                    [savedEstablishments addObject:nome];
                    PFFile *imagem = objects[i][@"pictureSalvos"];
                    [favoriteImages addObject:imagem];
                };
                [self.tableView reloadData];
            }else{
                 NSLog(@"Nenhum favorito encontrado ao procurar lista de favoritos");
            }
        } else {
             NSLog(@"Error: %@", error);
        }
        activityLoadingFavs.hidesWhenStopped = true;
        [activityLoadingFavs stopAnimating];
    }];
    }else{
        activityLoadingFavs.hidesWhenStopped = true;
        [activityLoadingFavs stopAnimating];
    };
    
    
    //savedEstablishments = [NSArray arrayWithObjects:@"Biruta Bar", @"Paço do Frevo", nil];
    
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
    
    return cell;
}


@end
