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
    NSLog(@"hahaha");
   //[PFUser logOut];
    PFUser *userF = [PFUser currentUser];
    //[PFUser logOut];
    if (userF) {
        dispatch_queue_t downloadQueue = dispatch_queue_create("downloader", NULL);
        dispatch_async(downloadQueue, ^{
            //Checking if place is in users favoritePlaces list
            NSString *id_place = place[@"id_place"];
            PFQuery *queryPlace = [PFQuery queryWithClassName:@"Place"];
            [queryPlace whereKey:@"id_place" equalTo:id_place];
            PFQuery *queryUser = [PFQuery queryWithClassName:@"FavoritePlaces"];
            NSLog(@"objectId");
            NSLog([[PFUser currentUser] objectId]);
            NSLog(@"eita");
            [queryUser whereKey:@"user" equalTo:[[PFUser currentUser] objectId]];
            [queryUser whereKey:@"places" matchesQuery:queryPlace];
            [queryUser findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    if([objects count] > 0){
                        NSLog(@"Está na lista de favoritos");
                    }else{
                        NSLog(@"NAAAO ESTAAAH NA LISTAAA");
                    }
                } else {
                    NSLog(@"Error: %@", error);
                }
            }];
            
            //Saving place to favorites list
//            PFQuery *queryPlaceSave = [PFQuery queryWithClassName:@"FavoritePlaces"];
//            [queryPlaceSave whereKey:@"user" equalTo:[[PFUser currentUser] objectId]];
//            [queryPlaceSave findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//                if (!error) {
//                    NSString *objectId = [place objectId];
//                    PFObject *pointer = [PFObject objectWithoutDataWithClassName:@"Place" objectId:objectId];
//                    if([objects count] > 0){
//                        NSLog(@"PRA SALVAR Está na lista de favoritos");
//                        [objects[0] addUniqueObjectsFromArray:@[pointer] forKey:@"places"];
//                        [objects[0] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                            if (succeeded) {
//                                NSLog(@"PRA SALVAR salvou NOVO");
//                            } else {
//                                // There was a problem, check error.description
//                                NSLog(@"PRA SALVAR Error");
//                                
//                            }
//                        }];
//                    }else{
//                        PFObject *gameScore = [PFObject objectWithClassName:@"FavoritePlaces"];
//                        gameScore[@"user"] = [userF objectId];
//                        [gameScore addUniqueObjectsFromArray:@[pointer] forKey:@"places"];
//                        [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                            if (succeeded) {
//                                NSLog(@"PRA SALVAR salvou");
//                            } else {
//                                // There was a problem, check error.description
//                                NSLog(@"PRA SALVAR Error");
//                                
//                            }
//                        }];
//                    }
//                } else {
//                    NSLog(@"Error: %@", error);
//                }
//            }];
            
        });
        dispatch_async(dispatch_get_main_queue() , ^{
            //Do stuff
        });
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
//    NSString *id_place = place[@"id_place"];
//    PFQuery *queryPlace = [PFQuery queryWithClassName:@"Place"];
//    [queryPlace whereKey:@"id_place" equalTo:id_place];
//    PFQuery *queryUser = [PFUser query];
//    [queryUser whereKey:@"username" equalTo:[[PFUser currentUser]username]];
//    [queryUser whereKey:@"favoritePlaces" matchesQuery:queryPlace];
//    [queryUser findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            if([objects count] > 0){
//                NSLog(@"Está na lista de favoritos");
//            }else{
//                NSLog(@"NAAAO ESTAAAH NA LISTAAA");
//                NSString *objectId = [place objectId];
//                NSLog(objectId);
//                PFObject *pointer = [PFObject objectWithoutDataWithClassName:@"Place" objectId:objectId];
//                PFObject *gameScore = [PFObject objectWithClassName:@"FavoritePlaces"];
//                PFObject *usuario = [PFUser currentUser];
//                gameScore[@"userrr"] = usuario;
//                gameScore[@"place"] = pointer;
//                gameScore[@"places"] = @[pointer];
//                [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                    if (succeeded) {
//                        NSLog(@"salvou");
//                    } else {
//                        // There was a problem, check error.description
//                        NSLog(@"Error");
//                        
//                    }
//                }];
//            }
//        } else {
//            NSLog(@"Error: %@", error);
//        }
//    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    [[[UIAlertView alloc] initWithTitle:@"Error"
                                message:@"Wrong username or password!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissModalViewControllerAnimated:YES]; // Dismiss the PFSignUpViewController
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
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
