//
//  NewsDetailController.m
//  CityGuide
//
//  Created by Taras on 7/20/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "NewsDetailController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NewsDetailController ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITextView *text;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation NewsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Новость";
    self.navigationItem.rightBarButtonItem = [AppManager plusButton:self andSelector:@selector(openSendController)];
    
    if (self.souceDictionary != nil) {
        self.name.text = self.souceDictionary[title_key];
        [self.image sd_setImageWithURL:self.souceDictionary[image_key]];
        self.text.text = self.souceDictionary[details_key];
    }}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)openSendController{
    [self.navigationController pushViewController:[SendMessageViewController new] animated:YES];
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
