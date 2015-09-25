//
//  UserViewController.h
//  waho
//
//  Created by Déborah Mesquita on 06/08/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLoginViewController.h"
#import "MySignUpViewController.h"
#import <MessageUI/MessageUI.h>
#import <Parse/Parse.h>

@interface UserViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, MFMailComposeViewControllerDelegate, UITabBarControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblNome;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UIButton *btRecomendarLocal;
@property (weak, nonatomic) IBOutlet UIButton *btLogoff;
@property (weak, nonatomic) IBOutlet UIButton *lblImage;
@property (weak, nonatomic) IBOutlet UILabel *lblLogin;
@property (weak, nonatomic) IBOutlet UIButton *btLogin;


@end
