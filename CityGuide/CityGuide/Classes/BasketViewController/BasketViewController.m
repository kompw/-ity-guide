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
#import <MessageUI/MessageUI.h>
#import "WToast.h"

static NSString *reuseIdentifier = @"cell";

@interface BasketViewController () <UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate,DishesCellDelegate>
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

-(void)addDishes:(NSDictionary*)dishesModel andPieces:(NSInteger)pieces atController:(UIViewController*)controller{
    if (self.restarauntModelOther) {
        UIAlertController *optionMenu = [UIAlertController alertControllerWithTitle:@"" message:@"Отчистить корзину и добавить новое блюдо?" preferredStyle:UIAlertControllerStyleAlert];
        
            UIAlertAction *yesButtom = [UIAlertAction actionWithTitle:@"Да" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [dishes removeAllObjects];
                [self.tableView reloadData];
                [self addNewDishes:dishesModel andPieces:pieces];
                
                self.restarauntModelMain = [self.restarauntModelOther copy];
                self.restarauntModelOther = nil;
                
               [WToast showWithText:@"Товар добавлен в корзину!" duration:kWTShort roundedCorners:YES];
            }];
        
            UIAlertAction *noButtom = [UIAlertAction actionWithTitle:@"Нет" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [WToast showWithText:@"Товар не добавлен!" duration:kWTShort roundedCorners:YES];
            }];
        
            [optionMenu addAction:yesButtom];
            [optionMenu addAction:noButtom];
     
        [controller presentViewController:optionMenu animated:YES completion:nil];
    }else{
        [self addNewDishes:dishesModel andPieces:pieces];
        [WToast showWithText:@"Товар добавлен в корзину!" duration:kWTShort roundedCorners:YES];
    }
}

-(NSInteger)countDishes{
    return dishes.count;
}

//private metod

-(void)addNewDishes:(NSDictionary*)dishesModel andPieces:(NSInteger)piece{
    DishesModel *dishe= [DishesModel new];
    dishe.count = piece;
    dishe.price = [dishesModel[price_key] integerValue];
    dishe.name = dishesModel[name_key];
    dishe.urlImage = dishesModel[image_key];
    
    [dishes addObject:dishe];
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.restarauntModelMain) {
        self.name.text = self.restarauntModelMain[name_key];
        [self.phoneButton setTitle:self.restarauntModelMain[phone_key] forState:UIControlStateNormal];
        [self.image sd_setImageWithURL:[NSURL URLWithString:self.restarauntModelMain[image_key]]];
        
        [self refreshAllPriceAndAllDishes];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Корзина";
    [self.tableView registerNib:[UINib nibWithNibName:[DishesCell description] bundle:nil] forCellReuseIdentifier:reuseIdentifier];
}


- (IBAction)call:(id)sender {
    NSString *phoneNumber = [@"tel://" stringByAppendingString:self.restarauntModelMain[phone_key]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

- (IBAction)sendEmail:(id)sender {
    NSMutableString *messageBody = [NSMutableString new];
    
    for (DishesModel *model in self.dishes) {
        if (model.count != 0){
            [messageBody appendFormat:@"%@  %ld шт \n",model.name,(long)model.count];
        }
    }

    NSArray *toRecipents = [NSArray arrayWithObject:self.restarauntModelMain[email_key]];
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:@"Заказ"];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:NULL];
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [dishes removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self refreshAllPriceAndAllDishes];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Удалить";
}

#pragma DishesCellDelegate

-(void)changeCountDishes:(NSInteger)count forCell:(DishesCell*)cell{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    DishesModel *model = dishes[index.row];
    model.count = count;
    [self.tableView reloadData];
    
    [self refreshAllPriceAndAllDishes];
}

-(void)refreshAllPriceAndAllDishes{
    NSInteger allDishes = 0;
    NSInteger allPrice = 0;
    
    for (DishesModel *model in self.dishes) {
        allDishes += model.count;
        allPrice += model.count * model.price;
    }
    
    self.allDishes.text = [NSString stringWithFormat:@"%ld шт",(long)allDishes];
    self.allPrice.text = [NSString stringWithFormat:@"₽ %ld",(long)allPrice];
}

@end
