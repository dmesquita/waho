//
//  MapAndListContainerViewController.m
//  waho
//
//  Created by Déborah Mesquita on 16/07/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "MapAndListContainerViewController.h"

@interface MapAndListContainerViewController ()

@end

@implementation MapAndListContainerViewController

@synthesize segmentControl, containerMap, containerList;

- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
    case 0 :
            containerMap.hidden = false;
            containerList.hidden = true;
            break;
    case 1:
            containerMap.hidden = true;
            containerList.hidden = false;
            //[[self.childViewControllers objectAtIndex:1]setPlacesArray:[[PlacesFromParse sharedPlacesFromParse]placesArray]];
            [[self.childViewControllers objectAtIndex:1]setItems:[[PlacesFromParse sharedPlacesFromParse]placesArray]];
            [[[self.childViewControllers objectAtIndex:1]tableView] reloadData];
            break;
            
    default:
            break;
    }
}

- (void)viewDidLoad {    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"Helvetica" size:16], NSFontAttributeName,
                                [UIColor blackColor], NSForegroundColorAttributeName, nil];
    [segmentControl setTitleTextAttributes:attributes forState:UIControlStateSelected];
    [segmentControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    [super viewDidLoad];
    containerMap.hidden = false;
    containerList.hidden = true;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if(item == 0){
        containerMap.hidden = false;
        containerList.hidden = true;
    }else{
        NSLog(@"aaaaa");
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
}

- (void)viewDidAppear:(BOOL)animated{
    //containerMap.hidden = false;
    //containerList.hidden = true;
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
