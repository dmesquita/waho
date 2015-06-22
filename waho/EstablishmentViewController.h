//
//  EstablishmentViewController.h
//  waho
//
//  Created by José Luiz Correia Neto on 12/06/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "LogInViewController.h"

@interface EstablishmentViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>


@property (strong, nonatomic) IBOutlet UIView *storyView;
@property (strong, nonatomic) IBOutlet UIView *localView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControlEstablishment;

@property (weak, nonatomic) IBOutlet UILabel *lblFavoritado;
@property(nonatomic) PFObject *place;
@property(nonatomic) NSMutableArray *favoritedPlaces;

@property (weak, nonatomic) IBOutlet PFImageView *imgPerson;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblQuote;
@property (weak, nonatomic) IBOutlet UITextView *txtStory;

- (IBAction)segmentValeuChanged:(id)sender;

@end
