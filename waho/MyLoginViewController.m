//
//  MyLoginViewController.m
//  waho
//
//  Created by Déborah Mesquita on 06/08/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "MyLoginViewController.h"
#import <ParseUI/PFLogInView.h>

@interface MyLoginViewController ()
@property (nonatomic, strong) UIImageView *fieldsBackground;
@end

@implementation MyLoginViewController

@synthesize fieldsBackground;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"waho text"]]];
    [self.logInView.logInButton setTitle:@"Entrar" forState:UIControlStateNormal];
    self.logInView.usernameField.placeholder = @"Usuário" ;
    self.logInView.passwordField.placeholder = @"******" ;
    [self.logInView.passwordForgottenButton setTitle:@"Esqueceu a senha?" forState:UIControlStateNormal];
    self.logInView.signUpButton.titleLabel.text = @"Cadastrar-se" ;
    
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
