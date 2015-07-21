//
//  FilterMapView.h
//  CityGuide
//
//  Created by Taras on 7/21/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterMapView : UIView
@property (weak, nonatomic) IBOutlet UIView *marker;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;
@property (weak, nonatomic) IBOutlet UILabel *title;
@end
