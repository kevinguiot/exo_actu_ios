//
//  ActuTableViewCell.m
//  exo_actu_ios
//
//  Created by GUIOT Kevin on 22/03/2017.
//  Copyright © 2017 GUIOT Kevin. All rights reserved.
//

#import "ActuTableViewCell.h"

@implementation ActuTableViewCell

@synthesize title = _title;
@synthesize image = _image;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
