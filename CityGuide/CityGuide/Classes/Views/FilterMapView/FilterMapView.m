//
//  FilterMapView.m
//  CityGuide
//
//  Created by Taras on 7/21/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "FilterMapView.h"

@implementation FilterMapView
- (void)awakeFromNib {
    [AppManager roundMyView:self.marker borderRadius:7 borderWidth:0 color:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
