//
//  Poster3Cell.h
//  CityGuide
//
//  Created by Taras on 7/21/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Poster3Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *desc;

-(void)setDataWithDictionary:(NSDictionary*)dic;

@end
