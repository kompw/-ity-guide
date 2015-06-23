//
//  MainMenuCell.h
//  CityGuide
//
//  Created by taras on 23.06.15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *data;

-(void)configure:(UIImage*)image andTitle:(NSString*)title andData:(NSString*)data;
@end
