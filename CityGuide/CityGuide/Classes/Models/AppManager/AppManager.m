//
//  AppManager.m
//  CityGuide
//
//  Created by taras on 23.06.15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "AppManager.h"
#import "SVProgressHUD.h"

@implementation AppManager

+(void)showProgressBar{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Loading", nil) maskType:SVProgressHUDMaskTypeBlack];
}

+(void)hideProgressBar{
    [SVProgressHUD dismiss];
}

+(void)showMessage:(NSString*)message{
    UIAlertView *alertView =  [[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
}



@end
