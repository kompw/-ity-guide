//
//  DishesViewController.m
//  CityGuide
//
//  Created by Taras on 6/26/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "DishesViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface DishesViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITextView *detail;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *piece;

@property int numberPiece;
@end

@implementation DishesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [AppManager backetButton:self];
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:self.souceDictionary[image_key]]];
    self.name.text = self.souceDictionary[name_key];
    self.detail.text = self.souceDictionary[description_key];
    self.price.text = [NSString stringWithFormat:@"₽ %@",self.souceDictionary[price_key]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changePiece:(id)sender {
    double value = [(UIStepper*)sender value];
    self.numberPiece = (int)value;
    
    [self.piece setText:[NSString stringWithFormat:@"%d шт", self.numberPiece]];
}

- (IBAction)addBasket:(id)sender {
    if (self.numberPiece == 0) {
        return;
    }
    
    BasketViewController *basketViewController = [BasketViewController sharedManager];
    [basketViewController addDishes:self.souceDictionary andPieces:self.numberPiece atController:self];
}

-(void)openBacket{
    BasketViewController *basketViewController = [BasketViewController sharedManager];
    
    if ([basketViewController countDishes] == 0) {
        return;
    }
    
    [self.navigationController pushViewController:basketViewController animated:YES];
}

@end
