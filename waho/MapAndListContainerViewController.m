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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ( [defaults integerForKey:@"view_tuts"] == nil ) {
            [defaults setInteger:0 forKey:@"view_tuts"];
            [defaults synchronize];
    }
    
    if ( [defaults integerForKey:@"view_tuts"] == 0 ) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"Tuts"];
        [self.parentViewController presentViewController:vc animated:YES completion:nil];
        [defaults setInteger:1 forKey:@"view_tuts"];
        [defaults synchronize];
    }
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"Helvetica" size:16], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    NSDictionary *attributesSelected = [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"Helvetica" size:16], NSFontAttributeName,
                                [UIColor  colorWithRed:253.0/255.0 green:66.0/255.0 blue:107.0/255.0 alpha:1], NSForegroundColorAttributeName, nil];
    [segmentControl setTitleTextAttributes:attributesSelected forState:UIControlStateSelected];
    [segmentControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    [super viewDidLoad];
    containerMap.hidden = false;
    containerList.hidden = true;   
    
    UITabBarController *tabBarController = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController ;
    
    [tabBarController setDelegate:self];
    
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    containerMap.hidden = false;
    containerList.hidden = true;
    segmentControl.selectedSegmentIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
