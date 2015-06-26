//
//  DishesCell.h
//  CityGuide
//
//  Created by Taras on 6/26/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DishesCell;
@protocol DishesCellDelegate <NSObject>
-(void)changeCountDishes:(NSInteger)count forCell:(DishesCell*)cell;
@end

@interface DishesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *countDishes;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;

@property id<DishesCellDelegate> delegate;
@end
