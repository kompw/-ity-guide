//
//  Poster3Cell.m
//  CityGuide
//
//  Created by Taras on 7/21/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "Poster3Cell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation Poster3Cell

- (void)awakeFromNib {
    [AppManager roundMyView:self.image borderRadius:3 borderWidth:0 color:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDataWithDictionary:(NSDictionary*)dic{
    [self.image sd_setImageWithURL:[NSURL URLWithString:dic[image_key]]];
    self.title.text = dic[name_key];
    self.desc.text = dic[description_key];
    self.price.text = [NSString stringWithFormat:@"%@ руб",dic[price_key]];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

@end
