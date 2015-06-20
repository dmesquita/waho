//
//  EstablishmentViewController.m
//  waho
//
//  Created by José Luiz Correia Neto on 12/06/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "EstablishmentViewController.h"

@interface EstablishmentViewController ()

@end

@implementation EstablishmentViewController
@synthesize storyView, localView, lbName, lbNameLocal, lbNameStory, lbAbout, txtAboutLocal, txtAboutStory, place;

- (void)viewDidLoad {
    [super viewDidLoad];
    lbNameLocal.text = lbName;
    lbNameStory.text = lbName;
    txtAboutLocal.text = lbAbout;
    txtAboutStory.text = lbAbout;

    // Do any additional setup after loading the view.
}
- (IBAction)favBtPressed:(id)sender {
    NSLog(@"oi");
}
- (IBAction)irPressed:(id)sender {
//    PFObject * query = [PFObject objectWithClassName:@"_User"];
//    query[@"favoritePlaces"] = @1337;
//    [query saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            // The object has been saved.
//        } else {
//            // There was a problem, check error.description
//        }
//    }];
    NSLog(@"hahaha");
    [PFUser logOut];
    PFUser *userF = [PFUser currentUser];
    [PFUser logOut];
    if (userF) {
        // do stuff with the user
        NSLog(@"Logado, querido");
    } else {
        // show the signup or login page
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self];
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
    
}

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    NSLog(@"logou eh tetraaa");
    
    //Check if place is in favoritePlaces list
    NSString *id_place = place[@"id_place"];
    PFQuery *queryPlace = [PFQuery queryWithClassName:@"Place"];
    [queryPlace whereKey:@"id_place" equalTo:id_place];
    PFQuery *queryUser = [PFUser query];
    [queryUser whereKey:@"username" equalTo:[[PFUser currentUser]username]];
    [queryUser whereKey:@"favoritePlaces" matchesQuery:queryPlace];
    [queryUser findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if([objects count] > 0){
                NSLog(@"Está na lista de favoritos");
            }else{
                NSLog(@"NAAAO ESTAAAH NA LISTAAA");
                NSString *objectId = [place objectId];
                NSLog(objectId);
                PFObject *pointer = [PFObject objectWithoutDataWithClassName:@"Place" objectId:objectId];
                
//                [currentUser addObjectsFromArray:@[pointer] forKey:@"favoritePlaces"];
//                [[PFUser currentUser] saveInBackground];
            }
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
    
    PFUser *currentUser = [PFUser currentUser];
    if([PFUser currentUser] != nil){
        NSLog(@"que merda eh essa");
    }
    user[@"teste"] = @"1337";
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Funcionou");
        }else{
            
        }
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (IBAction)segmentValeuChanged:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
            //story
        case 0:
            self.storyView.hidden = NO;
            self.localView.hidden = YES;
            break;
            //local
        case 1:
            self.storyView.hidden = YES;
            self.localView.hidden = NO;
            break;
            
        default:
            break;
    }
}
@end
