//
//  ItemSelectedViewController.h
//  exo_actu_ios
//
//  Created by GUIOT Kevin on 23/03/2017.
//  Copyright © 2017 GUIOT Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemSelectedViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *moreButtonNavigation;

@end
