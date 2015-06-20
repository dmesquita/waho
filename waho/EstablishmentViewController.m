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
//    PFQuery *query= [PFUser query];
//    
//    [query whereKey:@"username" equalTo:[[PFUser currentUser]username]];
//    
//    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
//        
//        BOOL isPrivate = [[object objectForKey:@"favoritePlaces"]boolValue];
//        
//    }];
    NSString *id_place = place[@"id_place"];
    PFQuery *queryPlace = [PFQuery queryWithClassName:@"Place"];
    [queryPlace whereKey:@"id_place" equalTo:id_place];
    PFQuery *queryUser = [PFUser query];
    [queryUser whereKey:@"username" equalTo:[[PFUser currentUser]username]];
    [queryUser whereKey:@"favoritePlaces" matchesQuery:queryPlace];
    [queryUser findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // Query succeeded - continue your app logic here.
            NSLog(@"Query ok");
            if([objects count] > 0){
                NSLog(@"Está na Lista");
            }else{
                NSLog(@"Não está na lista");            }
            
        } else {
            // Query failed - handle an error.
            NSLog(@"NÃO achou o objeto nos favoritos");
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
