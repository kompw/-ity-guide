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
static NSString *name_key = @"name";
static NSString *phone_key = @"phone";
static NSString *address_key = @"address";
static NSString *coordinates_key = @"coordinates";
static NSString *description_key = @"description";

@interface ServerManager : NSObject

+(NSArray*)getMainMenu;
+(void)sharesData:(void (^)(NSArray* array))completion;
+(void)directory1Data:(void (^)(NSArray* array))completion;
+(void)directory2Data:(NSString*)category_id forMap:(BOOL)forMap completion:(void (^)(NSArray* array))completion;
+(void)directory3Data:(NSString*)subcategory_id forMap:(BOOL)forMap completion:(void (^)(NSArray* array))completion;
+(void)newsData:(void (^)(NSArray* array))completion;
+(void)taxiData:(void (^)(NSArray* array))completion;

@end
