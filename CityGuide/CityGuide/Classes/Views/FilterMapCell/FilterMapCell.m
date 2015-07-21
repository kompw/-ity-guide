//
//  FilterMapCell.m
//  CityGuide
//
//  Created by Taras on 7/21/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "FilterMapCell.h"

@implementation FilterMapCell

- (void)awakeFromNib {
    [AppManager roundMyView:self.marker borderRadius:7 borderWidth:0 color:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
