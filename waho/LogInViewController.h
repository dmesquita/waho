//
//  LogInViewController.h
//  waho
//
//  Created by Déborah Mesquita on 18/06/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EstablishmentViewController.h"
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface LogInViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@end
