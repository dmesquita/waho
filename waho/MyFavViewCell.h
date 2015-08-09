//
//  MyFavViewCell.h
//  waho
//
//  Created by Déborah Mesquita on 08/08/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ParseUI/ParseUI.h"

@interface MyFavViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *imgFav;
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblPlace;


@end
