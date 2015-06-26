//
//  BasketViewController.m
//  CityGuide
//
//  Created by Taras on 6/26/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "BasketViewController.h"
#import "DishesModel.h"
#import "DishesCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

static NSString *ChangeDishes_key = @"changeDishes";
static NSString *reuseIdentifier = @"cell";

@interface BasketViewController () <UITableViewDataSource,UITableViewDelegate,DishesCellDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *allDishes;
@property (weak, nonatomic) IBOutlet UILabel *allPrice;

@property (nonatomic,strong) NSDictionary* restarauntModelMain;
@property (nonatomic,strong) NSDictionary* restarauntModelOther;
@property (nonatomic,strong) NSMutableArray* dishes;
@end

@implementation BasketViewController
@synthesize dishes;

+ (BasketViewController *)sharedManager
{
    static BasketViewController *shaderManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shaderManager = [[BasketViewController alloc] init];
        shaderManager.dishes = [NSMutableArray new];
    });
    return shaderManager;
}

-(void)newRestaraunt:(NSDictionary*)restarauntModel{
    if (dishes.count == 0) {
        self.restarauntModelMain = restarauntModel;
    }else if (![self.restarauntModelMain isEqualToDictionary:restarauntModel]){
        self.restarauntModelOther = restarauntModel;
    }else{
        self.restarauntModelOther = nil;
    }
}

-(void)addDishes:(NSDictionary*)dishesModel andPieces:(NSInteger)pieces{
    if (self.restarauntModelOther) {
        UIAlertController *optionMenu = [UIAlertController alertControllerWithTitle:@"" message:@"Отчистить корзину и добавить новое блюдо?" preferredStyle:UIAlertControllerStyleAlert];
        
            UIAlertAction *yesButtom = [UIAlertAction actionWithTitle:@"Да" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [dishes removeAllObjects];
                [self.tableView reloadData];
                [self addNewDishes:dishesModel andPieces:pieces];
            }];
        
            UIAlertAction *noButtom = [UIAlertAction actionWithTitle:@"Нет" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }];
        
            [optionMenu addAction:yesButtom];
            [optionMenu addAction:noButtom];
     
        [self presentViewController:optionMenu animated:YES completion:nil];
    }else{
        [self addNewDishes:dishesModel andPieces:pieces];
    }
}

-(NSInteger)countDishes{
    return dishes.count;
}

//private metod

-(void)addNewDishes:(NSDictionary*)dishesModel andPieces:(NSInteger)piece{
    DishesModel *dishe= [DishesModel new];
    dishe.count = piece;
    dishe.name = dishesModel[name_key];
    dishe.urlImage = dishesModel[image_key];
    
    [dishes addObject:dishe];
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Корзина";
    [self.tableView registerNib:[UINib nibWithNibName:[DishesCell description] bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    
    if (self.restarauntModelMain) {
        self.name = self.restarauntModelMain[name_key];
        [self.phoneButton setTitle:self.restarauntModelMain[price_key] forState:UIControlStateNormal];
        [self.image sd_setImageWithURL:[NSURL URLWithString:self.restarauntModelMain[image_key]]];
    }
    
    //[dishes addObserver:self forKeyPath:ChangeDishes_key options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:ChangeDishes_key]) {
        
    }
}

- (IBAction)call:(id)sender {
    NSString *phoneNumber = [@"tel://" stringByAppendingString:self.restarauntModelMain[phone_key]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

- (IBAction)sendEmail:(id)sender {
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dishes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DishesModel *model = dishes[indexPath.row];
    
    DishesCell* cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:[DishesCell description] owner:self options:nil] firstObject];
    }
    cell.name.text = model.name;
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model.urlImage]];
    cell.countDishes.text = [NSString stringWithFormat:@"%ld",(long)model.count];
    cell.stepper.value = model.count;
    cell.delegate = self;
 
    return cell;
}

#pragma DishesCellDelegate

-(void)changeCountDishes:(NSInteger)count forCell:(DishesCell*)cell{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    DishesModel *model = dishes[index.row];
    model.count = count;
    [self.tableView reloadData];
}

@end
