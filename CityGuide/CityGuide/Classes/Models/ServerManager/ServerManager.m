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

+(void)directoryData:(void (^)(NSArray* array))completion{
    NSString *url = [urlStr stringByAppendingString:@"catalog/get_categories.php"];
    [self baseGetReqestWithUrk:url completion:completion];
}

+(NSArray*)getMainMenu{
    return  @[ @{title_key: @"АКЦИИ", details_key: @"Скидки, купоны, спецпредложения", image_key: [UIImage imageNamed:@"1"]},
               @{title_key: @"СПРАВОЧНИК", details_key: @"Организации города, адреса, телефоны", image_key: [UIImage imageNamed:@"2"]},
               @{title_key: @"КАРТА", details_key: @"Карта городских организаций", image_key: [UIImage imageNamed:@"3"]},
               @{title_key: @"НОВОСТИ", details_key: @"Актуальные новости города", image_key: [UIImage imageNamed:@"4"]},
               @{title_key: @"ТАКСИ", details_key: @"Службы такси города", image_key: [UIImage imageNamed:@"5"]},
               @{title_key: @"ДОСТАВКА", details_key: @"Еда, цветы и другое", image_key: [UIImage imageNamed:@"6"]},
               @{title_key: @"ОБЪЯВЛЕНИЯ", details_key: @"ОБЪЯВЛЕНИЯ", image_key: [UIImage imageNamed:@"1"]}
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
