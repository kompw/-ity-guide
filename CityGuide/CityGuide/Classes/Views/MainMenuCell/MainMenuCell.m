//
//  MainMenuCell.m
//  CityGuide
//
//  Created by taras on 23.06.15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "MainMenuCell.h"

@implementation MainMenuCell

- (void)awakeFromNib {
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configure:(UIImage*)image andTitle:(NSString*)title andData:(NSString*)data{
    self.image.image = image;
    self.title.text = title;
    self.data.text = data;
}

@end
