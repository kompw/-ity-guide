//
//  ServerManager.m
//  CityGuide
//
//  Created by taras on 23.06.15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "ServerManager.h"
#import "AFNetworking.h"

static NSString *urlStr= @"http://citymy.ru/api/";

@implementation ServerManager

+(void)sharesData:(void (^)(NSArray* array))completion{
    NSString *url = [urlStr stringByAppendingString:@"sales/get_sales.php"];
    [self baseGetReqestWithUrk:url completion:completion];
}

+(void)newsData:(void (^)(NSArray* array))completion{
    NSString *url = [urlStr stringByAppendingString:@"news/get_news.php"];
    [self baseGetReqestWithUrk:url completion:completion];
}

+(void)taxiData:(void (^)(NSArray* array))completion{
    NSString *url = [urlStr stringByAppendingString:@"taxi/get_taxi.php"];
    [self baseGetReqestWithUrk:url completion:completion];
}

+(void)directory1Data:(void (^)(NSArray* array))completion{
    NSString *url = [urlStr stringByAppendingString:@"catalog/get_categories.php"];
    [self baseGetReqestWithUrk:url completion:completion];
}

+(void)directory2Data:(NSString*)category_id forMap:(BOOL)forMap completion:(void (^)(NSArray* array))completion{
    NSString *url =[NSString stringWithFormat:@"%@%@%@",urlStr,@"catalog/get_subcategories.php?category_id=",category_id];
    
    if (forMap) {
        url = [url stringByAppendingString:@"&for_map=1"];
    }
    
    [self baseGetReqestWithUrk:url completion:completion];
}

+(void)directory3Data:(NSString*)subcategory_id forMap:(BOOL)forMap completion:(void (^)(NSArray* array))completion{
    NSString *url =[NSString stringWithFormat:@"%@%@%@",urlStr,@"catalog/get_companies.php?subcategory_id=",subcategory_id];
    if (forMap) {
        url = [url stringByAppendingString:@"&for_map=1"];
    }
    
    [self baseGetReqestWithUrk:url completion:completion];
}

+(void)delivery1Data:(void (^)(NSArray* array))completion{
    NSString *url = [urlStr stringByAppendingString:@"delivery/get_restaraunts.php"];
    [self baseGetReqestWithUrk:url completion:completion];
}

+(void)delivery2Data:(NSString*)restaraunt_id completion:(void (^)(NSArray* array))completion{
    NSString *url =[NSString stringWithFormat:@"%@%@%@",urlStr,@"delivery/get_categories.php?restaraunt_id=",restaraunt_id];
    [self baseGetReqestWithUrk:url completion:completion];
}

+(void)delivery3Data:(NSString*)category_id completion:(void (^)(NSArray* array))completion{
    NSString *url =[NSString stringWithFormat:@"%@%@%@",urlStr,@"delivery/get_dishes.php?category_id=",category_id];
    [self baseGetReqestWithUrk:url completion:completion];
}

+(void)mapForAllData:(void (^)(NSArray* array))completion{
    NSString *url = [urlStr stringByAppendingString:@"map/get_map.php"];
    [self baseGetReqestWithUrk:url completion:completion];
}

+(void)mapForSubcategory:(NSString*)data completion:(void (^)(NSArray* array))completion{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",urlStr,@"map/get_map.php?subcategory_id=",data];
    [self baseGetReqestWithUrk:url completion:completion];
}

+(void)poster1Data:(void (^)(NSArray* array))completion{
    NSString *url = [urlStr stringByAppendingString:@"ads/get_categories.php"];
    [self baseGetReqestWithUrk:url completion:completion];
}

+(void)poster2Data:(NSString*)category_id completion:(void (^)(NSArray* array))completion{
    NSString *url =[NSString stringWithFormat:@"%@%@%@",urlStr,@"ads/get_subcategories.php?category_id=",category_id];
    [self baseGetReqestWithUrk:url completion:completion];
}

+(void)poster3Data:(NSString*)subcategory_id completion:(void (^)(NSArray* array))completion{
    NSString *url =[NSString stringWithFormat:@"%@%@%@",urlStr,@"ads/get_ads.php?subcategory_id=",subcategory_id];
    [self baseGetReqestWithUrk:url completion:completion];
}

+(void)sendNewPosterWithSubcategory:(NSString*)subcategory_id andImage:(NSData*)image andParameters:(NSDictionary*)parameters{
    NSString *url =[NSString stringWithFormat:@"%@%@%@",urlStr,@"ads/ads/create_ads.php=",subcategory_id];
    
    [AppManager showProgressBar];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFormData:image name:@"image"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isEqual:@"0"]) {
            [AppManager showMessage:@"Сообщение отправлено"];
        }else  if ([responseObject isEqual:@"1"]){
            [AppManager showMessage:@"Ошибка, нет всех данных"];
        }else
            [AppManager showMessage:@"Ошибка"];
        
        [AppManager hideProgressBar];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [AppManager showMessage:error.description];
        [AppManager hideProgressBar];
    }];
}

+(NSArray*)getMainMenu{
    return  @[ @{title_key: @"Ации", details_key: @"Скидки, купоны, спецпредложения", image_key: [UIImage imageNamed:@"action_x"]},
               @{title_key: @"Справочник", details_key: @"Организации города, адреса, телефоны", image_key: [UIImage imageNamed:@"help_x"]},
               @{title_key: @"Карта", details_key: @"Карта городских организаций", image_key: [UIImage imageNamed:@"map_x"]},
               @{title_key: @"Новости", details_key: @"Актуальные новости города", image_key: [UIImage imageNamed:@"news_x"]},
               @{title_key: @"Такси", details_key: @"Городские службы такси", image_key: [UIImage imageNamed:@"taxi_x"]},
               @{title_key: @"Доставка", details_key: @"Доставка еды,цветов и прочего", image_key: [UIImage imageNamed:@"delivery_x"]},
               @{title_key: @"Объявления", details_key: @"Продажа,покупка различных вещей", image_key: [UIImage imageNamed:@"ad_x"]}
             ];
}

//private

+(void)baseGetReqestWithUrk:(NSString*)url completion:(void (^)(NSArray* array))completion{
    [AppManager showProgressBar];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(responseObject);
        [AppManager hideProgressBar];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [AppManager showMessage:error.description];
        NSLog(@"Error: %@", error);
        [AppManager hideProgressBar];
    }];
}

@end
