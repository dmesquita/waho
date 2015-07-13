//
//  PageContentViewController.h
//  waho
//
//  Created by Déborah Mesquita on 29/06/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *descriptionText;
@property NSString *imageFile;

@end
