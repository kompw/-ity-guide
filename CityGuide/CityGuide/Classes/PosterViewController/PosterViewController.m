//
//  PosterViewController.m
//  CityGuide
//
//  Created by Taras on 7/1/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "PosterViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PosterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextView *text;
@property (weak, nonatomic) IBOutlet UILabel *created;
@property (weak, nonatomic) IBOutlet UILabel *author;

@end

@implementation PosterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Объявление";
    self.name.text = self.souceDictionary[name_key];
    [self.image sd_setImageWithURL:self.souceDictionary[image_key]];
    self.text.text = self.souceDictionary[description_key];
    [self.callButton setTitle:self.souceDictionary[phone_key] forState:UIControlStateNormal];
    self.price.text = [NSString stringWithFormat:@"₽ %@",self.souceDictionary[price_key]];
    self.created.text = self.souceDictionary[created_key];
    self.author.text = self.souceDictionary[author_key];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)call:(id)sender {
    NSString *phoneNumber = [@"tel://" stringByAppendingString:self.souceDictionary[phone_key]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

@end
