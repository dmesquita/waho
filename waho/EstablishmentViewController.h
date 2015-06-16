//
//  EstablishmentViewController.h
//  waho
//
//  Created by José Luiz Correia Neto on 12/06/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EstablishmentViewController : UIViewController{
    
}
@property (strong, nonatomic) IBOutlet UIView *storyView;
@property (strong, nonatomic) IBOutlet UIView *localView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControlEstablishment;
- (IBAction)segmentValeuChanged:(id)sender;

@end
