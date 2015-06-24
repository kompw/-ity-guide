//
//  CompanyViewController.m
//  CityGuide
//
//  Created by Taras on 6/24/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "CompanyViewController.h"
#import "MapViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CompanyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextView *descriptionCompany;
@property (weak, nonatomic) IBOutlet UIButton *phone;
@property (weak, nonatomic) IBOutlet UIButton *adress;


@end

@implementation CompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Компания";
    self.name.text = self.souceDictionary[name_key];
    [self.image sd_setImageWithURL:self.souceDictionary[image_key]];
    self.descriptionCompany.text = self.souceDictionary[description_key];
    [self.phone setTitle:self.souceDictionary[phone_key] forState:UIControlStateNormal];
    [self.adress setTitle:self.souceDictionary[address_key] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)phone:(id)sender {
    NSString *phoneNumber = [@"tel://" stringByAppendingString:self.souceDictionary[phone_key]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}
- (IBAction)adress:(id)sender {
    MapViewController *mapViewController = [MapViewController alloc];
    mapViewController.companyAdress = self.souceDictionary[address_key];
    mapViewController.companyName = self.souceDictionary[name_key];
    
    NSString *coordinates = self.souceDictionary[coordinates_key];
    
    if (!coordinates) {
        return;
    }
    
    NSArray *subStrings = [coordinates componentsSeparatedByString:@";"];
    mapViewController.coordinates = CLLocationCoordinate2DMake([subStrings.firstObject doubleValue], [subStrings.lastObject doubleValue]);
    [self.navigationController pushViewController:mapViewController animated:YES];
}

/*coordinates
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
