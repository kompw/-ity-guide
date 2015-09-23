//
//  MapViewController.m
//  CityGuide
//
//  Created by Taras on 6/24/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "MapViewController.h"
#import "FilterMapController.h"
#import "CompanyViewController.h"

static NSString *const kAPIKey = @"AIzaSyDz3EMFViCYM2m-UD7E1QZKnsdg98Rfmu4";

@interface MapViewController ()<FilterMapControllerDelegate,GMSMapViewDelegate>
@property (nonatomic, strong) GMSMapView *map;
@end

@implementation MapViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Карта";
    [GMSServices provideAPIKey:kAPIKey];
    
    UIButton *filterB = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [filterB setImage:[UIImage imageNamed:@"filtr_x.png"] forState:UIControlStateNormal];
    [filterB addTarget:self action:@selector(openFilter) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:filterB];

    GMSCameraPosition *camera;
    if (self.companyName) {
        camera = [GMSCameraPosition cameraWithLatitude:self.coordinates.latitude  longitude:self.coordinates.longitude zoom:10];
    }else{
        camera = [GMSCameraPosition cameraWithLatitude:55.436504  longitude:37.763629 zoom:10];
    }
    
    self.map = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    self.map.delegate = self;
    self.view = self.map;
    
    //set marker
    if (self.companyName) {
        [self createMarkerWithName:self.companyName andAdress:self.companyAdress andCoordinates:self.coordinates company_id:nil];
    }/*else{
        [ServerManager mapForAllData:^(NSArray *array) {
             [self workWithServerArray:array];
        }];
    }*/
}

-(void)workWithServerArray:(NSArray*)serverArray{
    for (NSDictionary *dic in serverArray) {
        NSArray *subStrings = [dic[coordinates_key] componentsSeparatedByString:@","];
        
        [self createMarkerWithName:dic[name_key] andAdress:dic[address_key] andCoordinates:CLLocationCoordinate2DMake([subStrings.firstObject doubleValue], [subStrings.lastObject doubleValue]) company_id:[dic[id_key] description]];
    }
}

-(void)createMarkerWithName:(NSString*)name andAdress:(NSString*)adress andCoordinates:(CLLocationCoordinate2D) coordinates company_id:(NSString*)company_id{
    GMSMarker *marker = [[GMSMarker alloc] init];
    
    marker.userData = company_id;
    marker.position = coordinates;
    marker.title = name;
    marker.snippet = adress;
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = (GMSMapView*)self.map;
}

-(void)openFilter{
    FilterMapController *filterMapController = [FilterMapController sharedManager];
    filterMapController.delegate = self;
    [self.navigationController pushViewController:filterMapController animated:YES];
}

#pragma FilterMapControllerDelegate

-(void)showMarkersWithData:(NSString*)data{
    [self.map clear];
    [ServerManager mapForSubcategory:data completion:^(NSArray *array) {
        [self workWithServerArray:array];
    }];
}

-(BOOL) mapView:(GMSMapView *) mapView didTapMarker:(GMSMarker *)marker
{
     if (self.companyName) {
         return NO;
     }else{
         NSString *numberId = marker.userData;
          [ServerManager  getCompany:numberId completion:^(NSArray* array) {
              if (array.count == 0) {
                  return;
              }
              
              CompanyViewController *companyViewController = [CompanyViewController alloc];
              companyViewController.souceDictionary = array.firstObject;
              [self.navigationController pushViewController:[companyViewController init] animated:YES];
          }];
        return YES;
     }
}


@end
