//
//  BaseDetailViewController.m
//  CityGuide
//
//  Created by Taras on 6/24/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "BaseDetailViewController.h"

@interface BaseDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation BaseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.detailData != nil) {
        self.textView.text = self.detailData;
    }else
        self.textView.text = @"Нет данных для отображения";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
