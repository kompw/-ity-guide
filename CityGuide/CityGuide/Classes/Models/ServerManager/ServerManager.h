//
//  ServerManager.h
//  CityGuide
//
//  Created by taras on 23.06.15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import <Foundation/Foundation.h>



static NSString *id_key = @"id";
static NSString *title_key = @"title";
static NSString *details_key = @"details";
static NSString *image_key = @"image";

@interface ServerManager : NSObject

+(void)sharesData:(void (^)(NSArray* array))completion;
+(void)newsData:(void (^)(NSArray* array))completion;
+(void)taxiData:(void (^)(NSArray* array))completion;
+(void)directoryData:(void (^)(NSArray* array))completion;
+(NSArray*)getMainMenu;

@end
