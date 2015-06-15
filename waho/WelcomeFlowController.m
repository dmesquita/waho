//
//  CustomPageViewController.m
//  PageViewController
//
//  Created by Tom Fewster on 11/01/2012.
//

#import "WelcomeFlowController.h"

@interface WelcomeFlowController ()

@end

@implementation WelcomeFlowController

@synthesize placesArray;

- (void)viewDidLoad
{
	// Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
    
    //Returning Place objects from Prase
    PFQuery *query = [PFQuery queryWithClassName:@"Place"];
    //query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query findObjectsInBackgroundWithBlock:^(NSArray *places, NSError *error) {
        if (!error) {
            placesArray = places;
            NSLog(@"Success retrieving objects from Parse!");
        } else {
            NSLog(@"Error while getting Place objects from Parse");
        }
    }];

	[self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"View1"]];
	[self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"View2"]];
	[self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"View3"]];
}

@end
