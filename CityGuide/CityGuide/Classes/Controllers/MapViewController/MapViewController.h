//
//  MapViewController.h
//  CityGuide
//
//  Created by Taras on 6/24/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController : UIViewController
@property  CLLocationCoordinate2D coordinates;
@property  (nonatomic,strong) NSString *companyName;
@property  (nonatomic,strong) NSString *companyAdress;
@end
