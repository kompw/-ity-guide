//
//  TaxiCell.h
//  CityGuide
//
//  Created by taras on 20.07.15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaxiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *desc;

-(void)setDataWithDictionary:(NSDictionary*)dic;
@end
