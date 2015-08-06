//
//  LogInViewController.h
//  waho
//
//  Created by Déborah Mesquita on 18/06/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "EstablishmentViewController.h"

@interface LogInViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@end
