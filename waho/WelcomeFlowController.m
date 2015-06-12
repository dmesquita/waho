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

- (void)viewDidLoad
{
	// Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];

	[self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"View1"]];
	[self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"View2"]];
	[self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"View3"]];
}

@end
