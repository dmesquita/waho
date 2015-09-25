//
//  ListViewTableViewCell.h
//  waho
//
//  Created by Déborah Mesquita on 19/07/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <ParseUI/ParseUI.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ListViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView  *imgBackground;
@property (weak, nonatomic) IBOutlet UIImageView *imgFav;
@property (weak, nonatomic) IBOutlet UIImageView *imgCategory;
@property (weak, nonatomic) IBOutlet UILabel *lbTitlePlace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintImgCategory;

@end
