//
//  CategoriesModel.m
//  CityGuide
//
//  Created by Taras on 7/21/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "CategoriesModel.h"

@implementation CategoriesModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.downCategories = [NSMutableArray new];
    }
    return self;
}
@end
