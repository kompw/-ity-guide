//
//  BaseViewController.h
//  CityGuide
//
//  Created by taras on 23.06.15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, Controller) {
    MainMenu,
    Shares,
    Delivery,
    Directory,
    Map,
    News,
    Taxi
};

@interface BaseViewController : UIViewController
@property (readwrite) Controller controllerType;
@property (nonatomic, strong) NSNumber *numberId;

@end
