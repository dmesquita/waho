//
//  UserViewController.m
//  waho
//
//  Created by Déborah Mesquita on 06/08/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

@synthesize lblNome, lblEmail;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFUser *userF = [PFUser currentUser];
    //[PFUser logOut];
    if (userF) {
        lblNome.text = userF[@"username"];
        lblEmail.text = userF[@"email"];
    } else {
        // show the signup or login page
        PFLogInViewController *logInViewController = [[MyLoginViewController alloc] init];
        [logInViewController setDelegate:self];
        
        [logInViewController setFields: PFLogInFieldsUsernameAndPassword | PFLogInFieldsPasswordForgotten | PFLogInFieldsSignUpButton | PFLogInFieldsFacebook | PFLogInFieldsDismissButton];
        
        
        PFSignUpViewController *signUpViewController = [[MySignUpViewController alloc] init];
        [signUpViewController setDelegate:self];
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
    
    UITabBarController *tabBarController = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController ;
    
    [tabBarController setDelegate:self];
    [tabBarController setSelectedIndex:2] ;

}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (tabBarController.selectedIndex == 2){
        PFUser *userF = [PFUser currentUser];
        //[PFUser logOut];
        if (userF) {
            lblNome.text = userF[@"username"];
            lblEmail.text = userF[@"email"];
        } else {
            // show the signup or login page
            PFLogInViewController *logInViewController = [[MyLoginViewController alloc] init];
            [logInViewController setDelegate:self];
            
            PFSignUpViewController *signUpViewController = [[MySignUpViewController alloc] init];
            [signUpViewController setDelegate:self];
            
            // Assign our sign up controller to be displayed from the login controller
            [logInViewController setSignUpController:signUpViewController];
            
            [self presentViewController:logInViewController animated:YES completion:NULL];
        }
    }    
}

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    NSLog(@"logou eh tetraaa");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)logoffClick:(UIButton *)sender {
    [PFUser logOut];
    [self logoffMessage];
}

- (IBAction)recomendarLocal:(UIButton *)sender {
    if ([MFMailComposeViewController canSendMail]){
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"mesquita.deh@gmail.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }else{
        [self emailFail];
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) emailFail{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Eitaaa!" message:@"Você precisa estar logado no app de emails do iPhone!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void) logoffMessage{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Logout" message:@"Logout efetuado com sucesso (feche o app para atualizar)" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
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
