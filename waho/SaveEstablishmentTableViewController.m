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
    PFUser *userF = [PFUser currentUser];
    if (userF) {
        [self hideLoginMessage];
        [self getFavoritedPlaces];
        tableView.hidden = NO;
    } else {
        // show the signup or login page
        [self showLoginMessage];
        tableView.hidden = YES;
        [self.lbLogin setPreferredMaxLayoutWidth:200.0];
    }
    
}

-(void)hideLoginMessage{
    self.lbLogin.hidden = YES;
    self.btLogin.hidden = YES;
}

-(void)showLoginMessage{
    self.lbLogin.hidden = NO;
    self.btLogin.hidden = NO;
}

- (IBAction)showLoginScreen:(id)sender {
    PFLogInViewController *logInViewController = [[MyLoginViewController alloc] init];
    [logInViewController setDelegate:self];
    
    [logInViewController setFields: PFLogInFieldsUsernameAndPassword | PFLogInFieldsPasswordForgotten | PFLogInFieldsSignUpButton | PFLogInFieldsFacebook | PFLogInFieldsDismissButton];
    
    
    PFSignUpViewController *signUpViewController = [[MySignUpViewController alloc] init];
    [signUpViewController setDelegate:self];
    
    // Assign our sign up controller to be displayed from the login controller
    [logInViewController setSignUpController:signUpViewController];
    [self presentViewController:logInViewController animated:YES completion:NULL];
}

-(void)viewDidAppear:(BOOL)animated{
    PFUser *userF = [PFUser currentUser];
    if (userF) {
        [self hideLoginMessage];
        [self getFavoritedPlaces];
        tableView.hidden = NO;
    } else {
        [self.lbLogin setPreferredMaxLayoutWidth:200.0];
        [self showLoginMessage];
        tableView.hidden = YES;
    }
}

-(void)getFavoritedPlaces{
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

- (void) getFavoritedPlacesFromParse {
    if ([PFUser currentUser] != nil) {
        PFQuery *queryUser = [PFQuery queryWithClassName:@"Place"];
        [queryUser whereKey:@"favorites" equalTo:[[PFUser currentUser] objectId]];
        [queryUser findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                [[PlacesFromParse sharedPlacesFromParse]setFavoritedPlaces:objects];
                if([objects count] > 0){
                    NSLog(@"Lista de favoritos encontrada");
                    for (int i = 0; i < [objects count]; i++) {
                        NSLog(objects[i][@"name"]);
                    };
                    [self getFavoritedPlaces];
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

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    NSLog(@"logou eh tetraaa1");
    [self _loadData];
    
    /* Now that user is logged in, get his favoritedPlaces array */
    [self getFavoritedPlacesFromParse];
    [self getFavoritedPlaces];
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)_loadData {
    // ...
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // result is a dictionary with the user's Facebook data
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *facebookID = userData[@"id"];
            NSString *name = userData[@"name"];
            
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
            UIImage *picture = [UIImage imageWithData: [NSData dataWithContentsOfURL:pictureURL]];
            
            
            NSData *imageData = UIImagePNGRepresentation(picture);
            PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
            [imageFile saveInBackground];
            
            PFUser *user = [PFUser currentUser];
            [user setObject:imageFile forKey:@"avatar"];
            [user setObject:name forKey:@"name"] ;
            [user saveInBackground];
        }
    }];
}

@end
