//
//  FilterMapController.h
//  CityGuide
//
//  Created by Taras on 7/20/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FilterMapController;
@protocol FilterMapControllerDelegate <NSObject>
-(void)showMarkersWithData:(NSArray*)data;
@end

@interface FilterMapController : UIViewController
@property (nonatomic,strong) id <FilterMapControllerDelegate> delegate;

+ (FilterMapController *)sharedManager;
@end
