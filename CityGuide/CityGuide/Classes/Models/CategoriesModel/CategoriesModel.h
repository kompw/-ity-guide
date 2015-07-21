//
//  CategoriesModel.h
//  CityGuide
//
//  Created by Taras on 7/21/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoriesModel : NSObject
@property (strong, nonatomic) NSString *catId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray *downCategories;
@property (assign, nonatomic) BOOL isSelect;
@property (assign, nonatomic) BOOL isOpen;
@end
/*@property (strong, nonatomic) NSString *downCatId;
 @property (strong, nonatomic) NSString *name;
 @property (assign, nonatomic) BOOL isSelect;*/