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
static NSString *phones_key = @"phones";
static NSString *address_key = @"address";
static NSString *coordinates_key = @"coordinates";
static NSString *description_key = @"description";
static NSString *price_key = @"price";
static NSString *email_key = @"email";
static NSString *created_key = @"created";
static NSString *author_key = @"author";
static NSString *date_key = @"date";
static NSString *site_key = @"site";

@interface ServerManager : NSObject

+(NSArray*)getMainMenu;
+(void)sharesData:(void (^)(NSArray* array))completion;
+(void)directory1Data:(void (^)(NSArray* array))completion;
+(void)directory2Data:(NSString*)category_id forMap:(BOOL)forMap completion:(void (^)(NSArray* array))completion;
+(void)directory3Data:(NSString*)subcategory_id forMap:(BOOL)forMap completion:(void (^)(NSArray* array))completion;
+(void)newsData:(void (^)(NSArray* array))completion;
+(void)taxiData:(void (^)(NSArray* array))completion;
+(void)delivery1Data:(void (^)(NSArray* array))completion;
+(void)delivery2Data:(NSString*)restaraunt_id completion:(void (^)(NSArray* array))completion;
+(void)delivery3Data:(NSString*)category_id completion:(void (^)(NSArray* array))completion;
+(void)mapForAllData:(void (^)(NSArray* array))completion;
+(void)mapForSubcategory:(NSString*)data completion:(void (^)(NSArray* array))completion;
+(void)poster1Data:(void (^)(NSArray* array))completion;
+(void)poster2Data:(NSString*)category_id completion:(void (^)(NSArray* array))completion;
+(void)poster3Data:(NSString*)subcategory_id completion:(void (^)(NSArray* array))completion;
+(void)sendNewPosterWithSubcategory:(NSString*)subcategory_id andImage:(NSData*)image andParameters:(NSDictionary*)parameters;
+(void)getCompany:(NSString*)company_id  completion:(void (^)(NSArray* array))completion;
@end
