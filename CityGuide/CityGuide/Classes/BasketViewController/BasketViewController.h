//
//  BasketViewController.h
//  CityGuide
//
//  Created by Taras on 6/26/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface BasketViewController : UIViewController

+ (BasketViewController *)sharedManager;

-(NSInteger)countDishes;

-(void)newRestaraunt:(NSDictionary*)restarauntModel;
-(void)addDishes:(NSDictionary*)dishesModel andPieces:(NSInteger)pieces;
@end
