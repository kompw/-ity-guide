//
//  DishesModel.h
//  CityGuide
//
//  Created by Taras on 6/26/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DishesModel : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *urlImage;
@property (nonatomic,readwrite) NSInteger count;
@property (nonatomic,readwrite) NSInteger price;
@end
