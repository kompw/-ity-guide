//
//  NewsCollectionCell.m
//  CityGuide
//
//  Created by Taras on 7/20/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "NewsCollectionCell.h"

@implementation NewsCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.frame = self.bounds;
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [AppManager roundMyView:self borderRadius:3 borderWidth:0 color:nil];
}

@end
