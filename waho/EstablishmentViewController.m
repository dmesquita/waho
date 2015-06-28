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
@synthesize viewPrincipal, storyView, localView, lblFavoritado, lblName, txtStory, lblQuote, place, favoritedPlaces, visitedPlaces, imgPerson, img2, img3, btFavoritar, btVisitei;

- (void)changeFavButtonToSaved{
    UIImage *bandeiraSalva = [UIImage imageNamed:@"bandeira_salvar"];
    [btFavoritar setBackgroundImage:bandeiraSalva forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([favoritedPlaces containsObject:place]){
        [self changeFavButtonToSaved];
        //NSLog(@"%d",[favoritedPlaces count]);
    }else{
        UIImage *bandeiraSalva = [UIImage imageNamed:@"bandeira_nao_salvo"];
        [btFavoritar setBackgroundImage:bandeiraSalva forState:UIControlStateNormal];
    }
    NSLog(@"%d",[visitedPlaces count]);
    if([visitedPlaces containsObject:place]){
        [btVisitei setEnabled:NO];
        NSLog(@"aAaaaaaaaaaaaaaaaaaa");
    }
    
    lblName.text = place[@"name"];
    lblQuote.text = place[@"quote"];
    txtStory.text = place[@"about"];
    NSArray *features = place[@"features"];
    for(int i = 0; i < [features count]; i++){
        UILabel *feat;
        //= [[UILabel alloc] initWithFrame:CGRectMake(63, 749+(i*24), 259, 21)];;
        //NSLog(@"imprimindo as features");
        [feat setFrame:CGRectMake(0,0, 259, 21)];
        [feat setFont:[UIFont fontNamesForFamilyName:@"Avenir"]];
        [feat setTextColor:[UIColor blackColor]];
        [feat setText:[features objectAtIndex:i]];
        [viewPrincipal addSubview:feat];
        //[features objectAtIndex:i];
    }
    //NSLog(objectAtIndex:0]);
    
    PFFile *imageFile = place[@"picture1"];
    imgPerson.file = imageFile;
    [imgPerson loadInBackground];
    
    PFFile *imageFile2 = place[@"picture2"];
    img2.file = imageFile2;
    [img2 loadInBackground];
    
    PFFile *imageFile3 = place[@"picture3"];
    img3.file = imageFile3;
    [img3 loadInBackground];

    // Do any additional setup after loading the view.
}


- (void) likePlace:(PFObject *)object{
    [object addUniqueObject:[[PFUser currentUser] objectId] forKey:@"favorites"];
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"local favoritado!");
            [favoritedPlaces addObject:place];
            [self favoritedSuccess];
        } else {
            [self favoritedFail];
            NSLog(@"Error: %@", error);
        }
    }];
}

- (IBAction)favoritarNovo:(UIButton *)sender {
    NSLog(@"hahaha");
    //[PFUser logOut];
    PFUser *userF = [PFUser currentUser];
    //[PFUser logOut];
    if (userF) {
        [self likePlace:place];
    } else {
        // show the signup or login page
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self];
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
}

- (void) favoritedSuccess{
    [self changeFavButtonToSaved];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sucesso!" message:@"Local favoritado com sucesso" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void) favoritedFail{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooooops!" message:@"Erro ao tentar favoritar local" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (IBAction)visitarNovo:(UIButton *)sender {
    PFUser *userF = [PFUser currentUser];
    if (userF) {
        //[self changeFavButtonToSaved];
        [self visitPlace:place];
    } else {
        // show the signup or login page
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self];
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
    
}

- (void) visitPlace:(PFObject *)object{
    [object addUniqueObject:[[PFUser currentUser] objectId] forKey:@"visited"];
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"local visitado!");
            [self visitedSuccess];
        } else {
            [self visitedFail];
            NSLog(@"Error: %@", error);
        }
    }];
}

- (void) visitedSuccess{
    [btVisitei setEnabled:NO];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sucesso!" message:@"Local visitado!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void) visitedFail{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooooops!" message:@"Erro ao tentar visitar local" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}


- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    NSLog(@"logou eh tetraaa");
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
    [signUpController setDelegate:self];
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
    [self.navigationController popViewControllerAnimated:YES];
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
