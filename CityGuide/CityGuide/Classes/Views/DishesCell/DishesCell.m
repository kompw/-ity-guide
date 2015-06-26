//
//  DishesCell.m
//  CityGuide
//
//  Created by Taras on 6/26/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "DishesCell.h"

@implementation DishesCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)changeCount:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeCountDishes:forCell:)]) {
        [self.delegate changeCountDishes:[(UIStepper*)sender value] forCell:self];
    }
}

@end
