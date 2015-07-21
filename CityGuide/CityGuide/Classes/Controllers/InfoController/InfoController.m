//
//  InfoController.m
//  CityGuide
//
//  Created by Taras on 7/20/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "InfoController.h"

@interface InfoController ()

@end

@implementation InfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"О приложении";
    self.navigationItem.rightBarButtonItem = [AppManager plusButton:self andSelector:@selector(openSendController)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)openSendController{
    [self.navigationController pushViewController:[SendMessageViewController new] animated:YES];
}

@end
