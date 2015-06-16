//
//  EstablishmentViewController.h
//  waho
//
//  Created by José Luiz Correia Neto on 12/06/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EstablishmentViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *storyView;
@property (strong, nonatomic) IBOutlet UIView *localView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControlEstablishment;
@property (weak, nonatomic) IBOutlet UILabel *lbNameStory;
@property (weak, nonatomic) IBOutlet UILabel *lbNameLocal;
@property (weak, nonatomic) IBOutlet UITextView *txtAboutStory;
@property (weak, nonatomic) IBOutlet UITextView *txtAboutLocal;

@property (nonatomic) IBOutlet NSString *lbName;
@property (nonatomic) IBOutlet NSString *lbAbout;

- (IBAction)segmentValeuChanged:(id)sender;

@end
