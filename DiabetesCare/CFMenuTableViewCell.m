//
//  cfMainMenuTableViewCell.m
//  DiabetesCare
//
//  Created by Chen, Fan on 7/10/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import "CFMenuTableViewCell.h"

@implementation CFMenuTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
