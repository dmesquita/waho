//
//  EstablishmentViewController.h
//  waho
//
//  Created by José Luiz Correia Neto on 12/06/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "MyLoginViewController.h"
#import "iCarousel.h"
#import "PlacesFromParse.h"

@interface EstablishmentViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, iCarouselDataSource, iCarouselDelegate>


@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic) NSArray *pictures;

@property (strong, nonatomic) IBOutlet UIView *storyView;
@property (strong, nonatomic) IBOutlet UIView *localView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControlEstablishment;
@property (weak, nonatomic) IBOutlet UIView *viewPrincipal;

@property (weak, nonatomic) IBOutlet UILabel *lblFavoritado;
@property(nonatomic) PFObject *place;
@property(nonatomic) NSMutableArray *favoritedPlaces;
@property(nonatomic) NSMutableArray *visitedPlaces;

@property (weak, nonatomic) IBOutlet PFImageView *imgPerson;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblQuote;
@property (weak, nonatomic) IBOutlet UITextView *txtStory;
@property (weak, nonatomic) IBOutlet UIButton *btFavoritar;
@property (weak, nonatomic) IBOutlet UIButton *btVisitei;

- (IBAction)segmentValeuChanged:(id)sender;

@end
