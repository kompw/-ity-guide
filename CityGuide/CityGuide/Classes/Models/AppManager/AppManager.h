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

@interface AppManager : NSObject

+(void)showProgressBar;
+(void)hideProgressBar;
+(void)showMessage:(NSString*)message;


@end
