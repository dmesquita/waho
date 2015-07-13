//
//  TabViewController.m
//  waho
//
//  Created by Déborah Mesquita on 29/06/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "TabViewController.h"

@interface TabViewController ()

@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(16452420)];
//    
//    //Customizing tabBarController
//    UITabBarController * tabBarController = (UITabBarController *)self.window.rootViewController;
//    UITabBar *tabBar = tabBarController.tabBar;
//    
//    // repeat for every tab, but increment the index each time
//    UITabBarItem *firstTab = [tabBar.items objectAtIndex:0];
//    UITabBarItem *secondTab = [tabBar.items objectAtIndex:1];
//    
//    // also repeat for every tab
//    firstTab.image = [[UIImage imageNamed:@"terra"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
//    firstTab.selectedImage = [[UIImage imageNamed:@"terra_cheia"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    // also repeat for every tab
//    secondTab.image = [[UIImage imageNamed:@"bandeira_vazia"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
//    secondTab.selectedImage = [[UIImage imageNamed:@"bandeira"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor grayColor] }
//                                             forState:UIControlStateNormal];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:251.0/255.0 green:11.0/255.0 blue:68.0/255.0 alpha:1.0] }
//                                             forState:UIControlStateSelected];
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
