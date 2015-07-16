//
//  MapAndListContainerViewController.h
//  waho
//
//  Created by Déborah Mesquita on 16/07/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapAndListContainerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UIView *containerMap;
@property (weak, nonatomic) IBOutlet UIView *containerList;

@end
