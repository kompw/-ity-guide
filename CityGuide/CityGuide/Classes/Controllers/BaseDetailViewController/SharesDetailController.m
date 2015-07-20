//
//  BaseDetailViewController.m
//  CityGuide
//
//  Created by Taras on 6/24/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "SharesDetailController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SharesDetailController ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextView *text;
@property (weak, nonatomic) IBOutlet UILabel *date;



@end

@implementation SharesDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Акция";
    self.navigationItem.rightBarButtonItem = [AppManager plusButton:self andSelector:@selector(openSendController)];
    
    if (self.souceDictionary != nil) {
        self.name.text = self.souceDictionary[title_key];
        [self.image sd_setImageWithURL:self.souceDictionary[image_key]];
        self.text.text = self.souceDictionary[details_key];
        self.date.text = self.souceDictionary[date_key];
    }
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)openSendController{
    [self.navigationController pushViewController:[SendMessageViewController new] animated:YES];
}


@end
