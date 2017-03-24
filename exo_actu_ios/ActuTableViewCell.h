//
//  ActuTableViewCell.h
//  exo_actu_ios
//
//  Created by GUIOT Kevin on 22/03/2017.
//  Copyright © 2017 GUIOT Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActuTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UILabel *title;
- (IBAction)moreButton:(id)sender;

@end
