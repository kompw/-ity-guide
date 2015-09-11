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
@property (weak, nonatomic) IBOutlet UILabel *adress;
@end

@implementation CompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Компания";
    self.navigationItem.rightBarButtonItem = [AppManager plusButton:self andSelector:@selector(openSendController)];
    self.name.text = self.souceDictionary[name_key];
    [self.image sd_setImageWithURL:self.souceDictionary[image_key]];
    self.descriptionCompany.text = self.souceDictionary[description_key];
    [self.phone setTitle:self.souceDictionary[phone_key] forState:UIControlStateNormal];
    self.adress.text = [NSString stringWithFormat:@"Адрес: %@",self.souceDictionary[address_key]];
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
    
    NSArray *subStrings = [coordinates componentsSeparatedByString:@","];
    mapViewController.coordinates = CLLocationCoordinate2DMake([subStrings.firstObject doubleValue], [subStrings.lastObject doubleValue]);
    [self.navigationController pushViewController:[mapViewController init] animated:YES];
}

-(void)openSendController{
    [self.navigationController pushViewController:[SendMessageViewController new] animated:YES];
}

@end
