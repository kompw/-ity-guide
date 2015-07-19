//
//  AppManager.h
//  CityGuide
//
//  Created by taras on 23.06.15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerManager.h"
#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

#define colorTextBlue() [UIColor colorWithRed:13/255.0 green:169/255.0 blue:242/255.0 alpha:1]

@interface AppManager : NSObject

+(void)showProgressBar;
+(void)hideProgressBar;
+(void)showMessage:(NSString*)message;
+(UIBarButtonItem*)backetButton:(UIViewController*)controller;
+(UIBarButtonItem*)plusButton:(UIViewController*)controller andSelector:(SEL)s;
+(void)roundMyView:(UIView*)view borderRadius:(CGFloat)radius borderWidth:(CGFloat)border color:(UIColor*)color;
@end
