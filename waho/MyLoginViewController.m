//
//  MyLoginViewController.m
//  waho
//
//  Created by Déborah Mesquita on 06/08/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "MyLoginViewController.h"

@interface MyLoginViewController ()
@property (nonatomic, strong) UIImageView *fieldsBackground;
@end

@implementation MyLoginViewController

@synthesize fieldsBackground;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"artesanato"]]];
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
