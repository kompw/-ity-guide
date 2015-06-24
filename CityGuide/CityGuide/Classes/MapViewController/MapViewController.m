//
//  MapViewController.m
//  CityGuide
//
//  Created by Taras on 6/24/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "MapViewController.h"
#import "ActionSheetPicker.h"

static NSString *const kAPIKey = @"AIzaSyCmrueEoID4P3XkUD5-EczuLLeW9Qicjgk";
static NSInteger hightDownCategoriesButton = 38;
@interface MapViewController ()
@property (weak, nonatomic) IBOutlet UIButton *categoriesButton;
@property (weak, nonatomic) IBOutlet UIButton *downCategoriesButton;
@property (weak, nonatomic) IBOutlet UIView *boxView;
@property (nonatomic, strong) GMSMapView *map;


@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSArray *downCategories;

@property NSInteger selectedIndexCategories;
@property NSInteger selectedIndexDownCategories;

@end

@implementation MapViewController
@synthesize downCategoriesButton;
@synthesize categoriesButton;
@synthesize selectedIndexCategories;
@synthesize selectedIndexDownCategories;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Карта";
    [GMSServices provideAPIKey:kAPIKey];

    GMSCameraPosition *camera;
    if (self.companyName) {
        downCategoriesButton.translatesAutoresizingMaskIntoConstraints = YES;
        downCategoriesButton.frame = CGRectMake(downCategoriesButton.frame.origin.x, - 2 * downCategoriesButton.frame.size.height, downCategoriesButton.frame.size.width, downCategoriesButton.frame.size.height);
        
        categoriesButton.translatesAutoresizingMaskIntoConstraints = YES;
        categoriesButton.frame = CGRectMake(categoriesButton.frame.origin.x, - categoriesButton.frame.size.height, categoriesButton.frame.size.width, categoriesButton.frame.size.height);
        
        camera = [GMSCameraPosition cameraWithLatitude:self.coordinates.latitude  longitude:self.coordinates.longitude zoom:6];
    }else{
        downCategoriesButton.translatesAutoresizingMaskIntoConstraints = YES;
        downCategoriesButton.frame = CGRectMake(downCategoriesButton.frame.origin.x, downCategoriesButton.frame.origin.y - hightDownCategoriesButton, downCategoriesButton.frame.size.width, downCategoriesButton.frame.size.height);
        
        camera = [GMSCameraPosition cameraWithLatitude:59.95907  longitude:30.318617 zoom:6];
    }
    
    
    self.map = [GMSMapView mapWithFrame:CGRectMake(0, 0, self.boxView.frame.size.width, self.boxView.frame.size.height) camera:camera];
    self.map.myLocationEnabled = YES;
    [self.boxView addSubview:self.map];
    
    //set marker
    if (self.companyName) {
        [self  createMarkerWithName:self.companyName andAdress:self.companyAdress andCoordinates:self.coordinates];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createMarkerWithName:(NSString*)name andAdress:(NSString*)adress andCoordinates:(CLLocationCoordinate2D) coordinates{
    GMSMarker *marker = [[GMSMarker alloc] init];
    
    marker.position = coordinates;
    marker.title = name;
    marker.snippet = adress;
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = (GMSMapView*)self.map;
}

- (IBAction)selectCategories:(id)sender {
    if (self.categories) {
        [self showCategories];
    }else
        [ServerManager directory1Data:^(NSArray *array) {
            self.categories = array;
            [self showCategories];
        }];
}

- (IBAction)selectDownCategories:(id)sender {
    if (self.downCategories) {
        [self showDownCategories];
    }else{
        NSDictionary *dic = self.categories[selectedIndexCategories];
        [ServerManager directory2Data:[dic[id_key] description] forMap:YES completion:^(NSArray *array) {
            self.downCategories = array;
            [self showDownCategories];
        }];
    }

}


-(void)showCategories{
    NSMutableArray *data = [NSMutableArray new];
    for (NSDictionary *dic in self.categories) {
        [data addObject:dic[name_key]];
    }
    
    [ActionSheetStringPicker showPickerWithTitle:@"Выберите категорию" rows:data initialSelection:selectedIndexCategories
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           selectedIndexCategories = selectedIndex;
                                           [categoriesButton setTitle:selectedValue forState:UIControlStateNormal];
                                           
                                           downCategoriesButton.translatesAutoresizingMaskIntoConstraints = NO;
                                           downCategoriesButton.hidden = NO;
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {}
                                          origin:categoriesButton];
}

-(void)showDownCategories{
    NSMutableArray *data = [NSMutableArray new];
    for (NSDictionary *dic in self.downCategories) {
        [data addObject:dic[name_key]];
    }
    
    [ActionSheetStringPicker showPickerWithTitle:@"Выберите субкатегорию" rows:data initialSelection:selectedIndexDownCategories
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           selectedIndexDownCategories = selectedIndex;
                                           [downCategoriesButton setTitle:selectedValue forState:UIControlStateNormal];
                                           
                                           [self.map clear];
                                           NSDictionary *dic = self.downCategories[selectedIndexDownCategories];
                                           [ServerManager directory3Data:[dic[id_key] description] forMap:YES completion:^(NSArray *array) {
                                               
                                               for (NSDictionary *dic in array) {
                                                   NSArray *subStrings = [dic[coordinates_key] componentsSeparatedByString:@";"];
                                                   
                                                   [self createMarkerWithName:dic[name_key] andAdress:dic[address_key] andCoordinates:CLLocationCoordinate2DMake([subStrings.firstObject doubleValue], [subStrings.lastObject doubleValue])];
                                               }
                                               
                                           }];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {}
                                          origin:downCategoriesButton];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
