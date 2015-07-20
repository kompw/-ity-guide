//
//  NewsCollectionCell.h
//  CityGuide
//
//  Created by Taras on 7/20/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *describe;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
