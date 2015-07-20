//
//  TaxiCell.m
//  CityGuide
//
//  Created by taras on 20.07.15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "TaxiCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation TaxiCell

- (void)awakeFromNib {
    self.layoutMargins = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = NO;
    [AppManager roundMyView:self.image borderRadius:5 borderWidth:0 color:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDataWithDictionary:(NSDictionary*)dic{
    [self.image sd_setImageWithURL:[NSURL URLWithString:dic[image_key]]];
    self.title.text = dic[name_key];
    self.desc.text = dic[description_key];
}

@end
