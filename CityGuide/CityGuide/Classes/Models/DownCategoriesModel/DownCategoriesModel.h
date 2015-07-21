//
//  DownCategoriesModel.h
//  CityGuide
//
//  Created by Taras on 7/21/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownCategoriesModel : NSObject
@property (strong,nonatomic) NSString *downCategoriesId;
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) BOOL isSelect;
@end
