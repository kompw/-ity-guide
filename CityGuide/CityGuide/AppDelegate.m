//
//  AppDelegate.m
//  CityGuide
//
//  Created by taras on 23.06.15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTableViewController.h"
#import <Parse/Parse.h>

#import "SharesDetailController.h"
#import "NewsDetailController.h"

static NSString * const kServerId = @"id";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self clearPush];
    [Parse setApplicationId:@"iVKZeXS1XoGlv7XMxYSJNVsuHAiVpxm2WFoJOtTn" clientKey:@"3uZz5ynrthsLXOn4qtXUCmq06mocUrbxsCS94hIa"];
    
    BaseTableViewController *baseViewController = [BaseTableViewController alloc];
    baseViewController.controllerType = MainMenu;
    
    UINavigationController *navigat = [[UINavigationController alloc]initWithRootViewController:[baseViewController init]];
    self.window.rootViewController = navigat;
    [self.window makeKeyAndVisible];
    
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    //open controller on push
    NSDictionary *userInfo = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        [self application:application didReceiveRemoteNotification:userInfo];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self clearPush];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self clearPush];
}

-(void)clearPush{
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    if (currentInstallation.badge != 0) {
        currentInstallation.badge = 0;
        [currentInstallation saveEventually];
    }
}

#pragma Parse and push

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[@"global"];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [AppManager showMessage:error.description];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    NSString *testPuth = userInfo[@"aps"][@"alert"];
    
    NSString *saleId = userInfo[@"sale_id"];
    NSString *newsId = userInfo[@"news_id"];
    
    UIViewController *currentViewController = ((UINavigationController *)self.window.rootViewController).topViewController;
    
    if (application.applicationState == UIApplicationStateActive) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSBundle.mainBundle.infoDictionary[@"CFBundleDisplayName"] message:testPuth preferredStyle:UIAlertControllerStyleAlert];
        if (saleId) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Отмена" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){ }];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Открыть" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                                        [self openSharesWithId:saleId toController:currentViewController];
                                      }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
        }else if (newsId){
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Отмена" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){ }];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Открыть" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                [self openNewsWithId:newsId toController:currentViewController];
            }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
        }else{
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){ }];
            [alertController addAction:okAction];
        }
        
        [currentViewController presentViewController:alertController animated:YES completion:nil];
       
    }else{
        
        if (saleId) {
            [self openSharesWithId:saleId toController:currentViewController];
        }else if (newsId){
            [self openNewsWithId:newsId toController:currentViewController];
        }
    }
}

-(void)openSharesWithId:(NSString*)sharesId toController:(UIViewController*)controller{
    NSNumber* _id = @([sharesId intValue]);
    
    [ServerManager sharesData:^(NSArray *array) {
        NSDictionary *model = [array filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id object, NSDictionary *bindings) {
            return [object[kServerId] isEqualToNumber:_id];
        }]].lastObject;
        if (model) {
            SharesDetailController *baseDetailViewController = [SharesDetailController alloc];
            baseDetailViewController.souceDictionary = model;
            [controller.navigationController pushViewController:[baseDetailViewController init] animated:YES];
        }
    }];
}

-(void)openNewsWithId:(NSString*)newsId toController:(UIViewController*)controller{
     NSNumber* _id = @([newsId intValue]);
    
    [ServerManager newsData:^(NSArray *array) {
        NSDictionary *model = [array filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id object, NSDictionary *bindings) {
            return [object[kServerId] isEqualToNumber:_id];
        }]].lastObject;

        if (model) {
            NewsDetailController *newsDetailController = [NewsDetailController alloc];
            newsDetailController.souceDictionary = model;
            [controller.navigationController pushViewController:[newsDetailController init] animated:YES];
        }
    }];
}

@end
