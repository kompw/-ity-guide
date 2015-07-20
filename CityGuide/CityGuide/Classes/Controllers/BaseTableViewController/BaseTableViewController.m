//
//  BaseViewController.m
//  CityGuide
//
//  Created by taras on 23.06.15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "BaseTableViewController.h"
#import "SharesDetailController.h"
#import "MapViewController.h"
#import "CompanyViewController.h"
#import "SendMessageViewController.h"
#import "DishesViewController.h"
#import "PosterViewController.h"

#import "SendView.h"
#import "MainMenuCell.h"
#import "TextCell.h"
#import "TextWithImageCell.h"
#import "MainHeaderView.h"

#import <SDWebImage/UIImageView+WebCache.h>

static NSString *reuseIdentifier = @"cell";

//all tab in main menu
typedef NS_ENUM(NSInteger, mainMenu) {
    SharesTab     = 0,
    DirectoryTab  = 1,
    MapTab        = 2,
    NewsTab       = 3,
    TaxiTab       = 4,
    DeliveryTab   = 5,
    PosterTab     = 6
};


@interface BaseTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerConst;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation BaseTableViewController
@synthesize dataSource;

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = @[];
    self.tableView.sectionHeaderHeight = 0;
    
    if (self.controllerType != MainMenu)
        self.navigationItem.rightBarButtonItem = [AppManager plusButton:self andSelector:@selector(openSendController)];
    
    switch (self.controllerType) {
        case MainMenu:{
            self.title = @"Главное меню";
            dataSource = [ServerManager getMainMenu];
            UIView * v = [[[NSBundle mainBundle] loadNibNamed:[MainMenuCell description] owner:self options:nil] firstObject];
            self.tableView.rowHeight = v.frame.size.height;
            [self.tableView registerNib:[UINib nibWithNibName:[MainMenuCell description] bundle:nil] forCellReuseIdentifier:reuseIdentifier];
            
            MainHeaderView *mainHeaderView = [[[NSBundle mainBundle] loadNibNamed:[MainHeaderView description] owner:self options:nil] firstObject];
            self.tableView.sectionHeaderHeight = mainHeaderView.frame.size.height;
            
            self.headerConst.constant = 0;
        }
            break;
        case Shares:{
            self.title = @"Акции";
            UIView * v = [[[NSBundle mainBundle] loadNibNamed:[TextWithImageCell description] owner:self options:nil] firstObject];
            self.tableView.rowHeight = v.frame.size.height;
            [self.tableView registerNib:[UINib nibWithNibName:[TextWithImageCell description] bundle:nil] forCellReuseIdentifier:reuseIdentifier];
            
            SendView *sendView = [[[NSBundle mainBundle] loadNibNamed:[SendView description] owner:self options:nil] firstObject];
            self.tableView.sectionHeaderHeight = sendView.frame.size.height;
           
            
            [ServerManager sharesData:^(NSArray *array) {
                dataSource = array;
                [self.tableView reloadData];
            }];
        }
            break;
        case Directory1:{
            self.title = @"Справочник";
            UIView * v = [[[NSBundle mainBundle] loadNibNamed:[TextWithImageCell description] owner:self options:nil] firstObject];
            self.tableView.rowHeight = v.frame.size.height;
            [self.tableView registerNib:[UINib nibWithNibName:[TextWithImageCell description] bundle:nil] forCellReuseIdentifier:reuseIdentifier];
            
            SendView *sendView = [[[NSBundle mainBundle] loadNibNamed:[SendView description] owner:self options:nil] firstObject];
            self.tableView.sectionHeaderHeight = sendView.frame.size.height;
            
            [ServerManager directory1Data:^(NSArray *array) {
                dataSource = array;
                [self.tableView reloadData];
            }];
        }
            break;
            
        case Directory2:{
            UIView * v = [[[NSBundle mainBundle] loadNibNamed:[TextCell description] owner:self options:nil] firstObject];
            self.tableView.rowHeight = v.frame.size.height;
            [self.tableView registerNib:[UINib nibWithNibName:[TextCell description] bundle:nil] forCellReuseIdentifier:reuseIdentifier];
            
            [ServerManager  directory2Data:self.numberId.description forMap:NO completion:^(NSArray *array) {
                dataSource = array;
                [self.tableView reloadData];
            }];
        }
            break;
            
        case Directory3:{
            UIView * v = [[[NSBundle mainBundle] loadNibNamed:[TextWithImageCell description] owner:self options:nil] firstObject];
            self.tableView.rowHeight = v.frame.size.height;
            [self.tableView registerNib:[UINib nibWithNibName:[TextWithImageCell description] bundle:nil] forCellReuseIdentifier:reuseIdentifier];
            
            [ServerManager  directory3Data:self.numberId.description forMap:NO completion:^(NSArray *array) {
                dataSource = array;
                [self.tableView reloadData];
            }];
        }
            break;
        case News:{
            self.title = @"Новости";
            UIView * v = [[[NSBundle mainBundle] loadNibNamed:[TextWithImageCell description] owner:self options:nil] firstObject];
            self.tableView.rowHeight = v.frame.size.height;
            [self.tableView registerNib:[UINib nibWithNibName:[TextWithImageCell description] bundle:nil] forCellReuseIdentifier:reuseIdentifier];
            
            SendView *sendView = [[[NSBundle mainBundle] loadNibNamed:[SendView description] owner:self options:nil] firstObject];
            self.tableView.sectionHeaderHeight = sendView.frame.size.height;
            
            
            [ServerManager newsData:^(NSArray *array) {
                dataSource = array;
                [self.tableView reloadData];
            }];
        }
            break;
        case Taxi:{
            self.title = @"Такси";
            UIView * v = [[[NSBundle mainBundle] loadNibNamed:[TextWithImageCell description] owner:self options:nil] firstObject];
            self.tableView.rowHeight = v.frame.size.height;
            [self.tableView registerNib:[UINib nibWithNibName:[TextWithImageCell description] bundle:nil] forCellReuseIdentifier:reuseIdentifier];
            
            SendView *sendView = [[[NSBundle mainBundle] loadNibNamed:[SendView description] owner:self options:nil] firstObject];
            self.tableView.sectionHeaderHeight = sendView.frame.size.height;
            
            
            [ServerManager taxiData:^(NSArray *array) {
                dataSource = array;
                [self.tableView reloadData];
            }];
        }
            break;
        case Delivery1:{
            self.title = @"Доставка";
            self.navigationItem.rightBarButtonItem = [AppManager backetButton:self];
            
            UIView * v = [[[NSBundle mainBundle] loadNibNamed:[TextWithImageCell  description] owner:self options:nil] firstObject];
            self.tableView.rowHeight = v.frame.size.height;
            [self.tableView registerNib:[UINib nibWithNibName:[TextWithImageCell  description] bundle:nil] forCellReuseIdentifier:reuseIdentifier];
            
            SendView *sendView = [[[NSBundle mainBundle] loadNibNamed:[SendView description] owner:self options:nil] firstObject];
            self.tableView.sectionHeaderHeight = sendView.frame.size.height;
            
            [ServerManager delivery1Data:^(NSArray *array) {
                dataSource = array;
                [self.tableView reloadData];
            }];
        }
            break;
        case Delivery2:{
            self.navigationItem.rightBarButtonItem = [AppManager backetButton:self];
            
            UIView * v = [[[NSBundle mainBundle] loadNibNamed:[TextCell description] owner:self options:nil] firstObject];
            self.tableView.rowHeight = v.frame.size.height;
            [self.tableView registerNib:[UINib nibWithNibName:[TextCell description] bundle:nil] forCellReuseIdentifier:reuseIdentifier];
            
            SendView *sendView = [[[NSBundle mainBundle] loadNibNamed:[SendView description] owner:self options:nil] firstObject];
            self.tableView.sectionHeaderHeight = sendView.frame.size.height;
            
            [ServerManager delivery2Data:self.numberId.description completion:^(NSArray *array) {
                dataSource = array;
                [self.tableView reloadData];
            }];
        }
            break;
        case Delivery3:{
            self.navigationItem.rightBarButtonItem = [AppManager backetButton:self];
            
            UIView * v = [[[NSBundle mainBundle] loadNibNamed:[TextWithImageCell description] owner:self options:nil] firstObject];
            self.tableView.rowHeight = v.frame.size.height;
            [self.tableView registerNib:[UINib nibWithNibName:[TextWithImageCell description] bundle:nil] forCellReuseIdentifier:reuseIdentifier];
            
            SendView *sendView = [[[NSBundle mainBundle] loadNibNamed:[SendView description] owner:self options:nil] firstObject];
            self.tableView.sectionHeaderHeight = sendView.frame.size.height;
            
            [ServerManager delivery3Data:self.numberId.description completion:^(NSArray *array) {
                dataSource = array;
                [self.tableView reloadData];
            }];
        }
            break;
        case Poster1:{
            self.title = @"Объявления";
            UIView * v = [[[NSBundle mainBundle] loadNibNamed:[TextCell  description] owner:self options:nil] firstObject];
            self.tableView.rowHeight = v.frame.size.height;
            [self.tableView registerNib:[UINib nibWithNibName:[TextCell  description] bundle:nil] forCellReuseIdentifier:reuseIdentifier];
   
            [ServerManager poster1Data:^(NSArray *array) {
                dataSource = array;
                [self.tableView reloadData];
            }];
        }
           break;
        case Poster2:{
            UIView * v = [[[NSBundle mainBundle] loadNibNamed:[TextCell  description] owner:self options:nil] firstObject];
            self.tableView.rowHeight = v.frame.size.height;
            [self.tableView registerNib:[UINib nibWithNibName:[TextCell  description] bundle:nil] forCellReuseIdentifier:reuseIdentifier];
            
            [ServerManager poster2Data:self.numberId.description completion:^(NSArray *array) {
                dataSource = array;
                [self.tableView reloadData];
            }];
        }
            break;
        case Poster3:{
            UIView * v = [[[NSBundle mainBundle] loadNibNamed:[TextWithImageCell  description] owner:self options:nil] firstObject];
            self.tableView.rowHeight = v.frame.size.height;
            [self.tableView registerNib:[UINib nibWithNibName:[TextWithImageCell  description] bundle:nil] forCellReuseIdentifier:reuseIdentifier];
            
            SendView *sendView = [[[NSBundle mainBundle] loadNibNamed:[SendView description] owner:self options:nil] firstObject];
            self.tableView.sectionHeaderHeight = sendView.frame.size.height;
            
            [ServerManager poster3Data:self.numberId.description completion:^(NSArray *array) {
                dataSource = array;
                [self.tableView reloadData];
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataSource.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SendView *sendView = [[[NSBundle mainBundle] loadNibNamed:[SendView description] owner:self options:nil] firstObject];
    [AppManager roundMyView:sendView.sendButton borderRadius:5 borderWidth:0 color:nil];
    [sendView.sendButton addTarget:self action:@selector(openSendController) forControlEvents:UIControlEventTouchUpInside];
    
    MainHeaderView *mainHeaderView;
    switch (self.controllerType) {
        case Directory2:
        case Directory3:
        case Poster2:
        case Poster1:
            return nil;
            break;
            
        case MainMenu:{
            mainHeaderView = [[[NSBundle mainBundle] loadNibNamed:[MainHeaderView description] owner:self options:nil] firstObject];
            mainHeaderView.navigationController = self.navigationController;
        }
            return mainHeaderView;
            
        case Shares:
            [sendView.sendButton setTitle:@"Разместить Акцию" forState: UIControlStateNormal];
            break;
            
        case Directory1:
            [sendView.sendButton setTitle:@"Разместить Компанию" forState: UIControlStateNormal];
            break;
        case News:
            [sendView.sendButton setTitle:@"Разместить новость" forState: UIControlStateNormal];
            break;
        case Taxi:
            [sendView.sendButton setTitle:@"Разместить службу такси" forState: UIControlStateNormal];
            break;
        case Delivery1:
        case Delivery2:
        case Delivery3:
            [sendView.sendButton setTitle:@"Разместить ресторан" forState: UIControlStateNormal];
            break;
        case Poster3:
            [sendView.sendButton setTitle:@"Разместить объявление" forState: UIControlStateNormal];
            break;
        default:
            break;
    }
    
    return sendView;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     NSDictionary *model = self.dataSource[indexPath.row];
     UITableViewCell *cell;

     switch (self.controllerType) {
         case MainMenu:{
             cell = [self mainMenuCell:indexPath andModel:model];
         }
             break;
         case News:
         case Shares:{
             cell = [self textWithImageCell:indexPath andTitle:model[title_key] andImageUrl:model[image_key]];
         }
             break;
         case Poster2:
         case Poster1:
         case Delivery2:
             cell = [self textCell:indexPath andModel:model];
             break;
         case Poster3:
         case Delivery3:
         case Delivery1:
         case Taxi:
         case Directory3:{
             cell = [self textWithImageCell:indexPath andTitle:model[name_key] andImageUrl:model[image_key]];
         }
             break;
        case Directory1:
             cell = [self textWithImageCell:indexPath andTitle:model[name_key] andImageUrl:model[image_key]];
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
             break;
        case Directory2:
             cell = [self textCell:indexPath andModel:model];
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
             break;
         default:
             break;
     }
     
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
  return cell;
 }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *model = self.dataSource[indexPath.row];
    
    switch (self.controllerType) {
        case MainMenu:{
            [self actionMainMenu:indexPath.row];
        }
            break;
        case News:
        case Shares:{
            SharesDetailController *baseDetailViewController = [SharesDetailController alloc];
            baseDetailViewController.souceDictionary = model;
            [self.navigationController pushViewController:[baseDetailViewController init] animated:YES];
        }
            break;
         
        case Directory1:{
            BaseTableViewController *baseTableViewController = [BaseTableViewController alloc];
            baseTableViewController.title = model[name_key];
            baseTableViewController.numberId = model[id_key];
            baseTableViewController.controllerType = Directory2;
            [self.navigationController pushViewController:[baseTableViewController init] animated:YES];
        }
            break;
        case Directory2:{
            BaseTableViewController *baseTableViewController = [BaseTableViewController alloc];
            baseTableViewController.title = model[name_key];
            baseTableViewController.numberId = model[id_key];
            baseTableViewController.controllerType = Directory3;
            [self.navigationController pushViewController:[baseTableViewController init] animated:YES];
        }
            break;
            
        case Directory3:{
            CompanyViewController *companyViewController = [CompanyViewController alloc];
            companyViewController.souceDictionary = model;
            [self.navigationController pushViewController:[companyViewController init] animated:YES];
        }
            break;
            
        case Taxi:{
            NSString *phones = model[phones_key];
            NSArray *phonesArray = [phones componentsSeparatedByString:@","];
            NSString *title = phonesArray.count == 1 ? @"Телефон для связи" : @"Телефоны для связи";
            UIAlertController *optionMenu = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            for (NSString *phone in phonesArray) {
                UIAlertAction *alert = [UIAlertAction actionWithTitle:phone style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    NSString *phoneNumber = [@"tel://" stringByAppendingString:phone];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
                }];
                [optionMenu addAction:alert];
            }
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Отмена" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }];
            [optionMenu addAction:cancel];
            
            [self presentViewController:optionMenu animated:YES completion:nil];
        }
            break;
        case Delivery1:{
            BaseTableViewController *baseTableViewController = [BaseTableViewController alloc];
            baseTableViewController.title = model[name_key];
            baseTableViewController.numberId = model[id_key];
            baseTableViewController.controllerType = Delivery2;
            [self.navigationController pushViewController:[baseTableViewController init] animated:YES];
            
            BasketViewController *basketViewController = [BasketViewController sharedManager];
            [basketViewController newRestaraunt:model];
        }
            break;
        case Delivery2:{
            BaseTableViewController *baseTableViewController = [BaseTableViewController alloc];
            baseTableViewController.title = model[name_key];
            baseTableViewController.numberId = model[id_key];
            baseTableViewController.controllerType = Delivery3;
            [self.navigationController pushViewController:[baseTableViewController init] animated:YES];
        }
            break;
        case Delivery3:{
            DishesViewController *dishesViewController = [DishesViewController alloc];
            dishesViewController.souceDictionary = model;
            [self.navigationController pushViewController:[dishesViewController init] animated:YES];
        }
            break;
        case Poster1:{
            BaseTableViewController *baseTableViewController = [BaseTableViewController alloc];
            baseTableViewController.title = model[name_key];
            baseTableViewController.numberId = model[id_key];
            baseTableViewController.controllerType = Poster2;
            [self.navigationController pushViewController:[baseTableViewController init] animated:YES];
        }
            break;
        case Poster2:{
            BaseTableViewController *baseTableViewController = [BaseTableViewController alloc];
            baseTableViewController.title = model[name_key];
            baseTableViewController.numberId = model[id_key];
            baseTableViewController.controllerType = Poster3;
            [self.navigationController pushViewController:[baseTableViewController init] animated:YES];
        }
            break;
        case Poster3:{
            PosterViewController *posterViewController = [PosterViewController alloc];
            posterViewController.souceDictionary = model;
            [self.navigationController pushViewController:[posterViewController init] animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma  configure cell

-(UITableViewCell*)mainMenuCell:(NSIndexPath *)indexPath andModel:(NSDictionary*)model{
    MainMenuCell* mainMenuCell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (mainMenuCell == nil) {
        mainMenuCell = [[[NSBundle mainBundle] loadNibNamed:[MainMenuCell description] owner:self options:nil] firstObject];
    }
    
    [mainMenuCell configure:model[image_key] andTitle:model[title_key] andData:model[details_key]];
    return mainMenuCell;
}

-(UITableViewCell*)textWithImageCell:(NSIndexPath *)indexPath andTitle:(NSString*)title andImageUrl:(NSString*)url{
    TextWithImageCell* textWithImageCell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (textWithImageCell == nil) {
        textWithImageCell = [[[NSBundle mainBundle] loadNibNamed:[TextWithImageCell description] owner:self options:nil] firstObject];
    }
    textWithImageCell.title.text = title;
    [textWithImageCell.image sd_setImageWithURL:[NSURL URLWithString:url]];
    
    switch (self.controllerType) {
        case Shares:
            textWithImageCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            textWithImageCell.image.contentMode = UIViewContentModeScaleAspectFit;
        case Directory1:
            textWithImageCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case Directory3:
            textWithImageCell.title.textColor = colorTextBlue();
            break;
        default:
            break;
    }
    
    return textWithImageCell;
}

-(UITableViewCell*)textCell:(NSIndexPath *)indexPath andModel:(NSDictionary*)model{
    TextCell* textWithImageCell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (textWithImageCell == nil) {
        textWithImageCell = [[[NSBundle mainBundle] loadNibNamed:[TextCell description] owner:self options:nil] firstObject];
    }
    textWithImageCell.title.text = model[name_key];
    
     switch (self.controllerType) {
         case Directory2:
             textWithImageCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
             break;
         default:
             break;
     }

    return textWithImageCell;
}

#pragma action mainMenu

-(void)actionMainMenu:(NSInteger)row{
    BaseTableViewController *baseViewController = [BaseTableViewController alloc];
    
    switch (row) {
        case SharesTab:
            baseViewController.controllerType = Shares;
            break;
        case DirectoryTab:
            baseViewController.controllerType = Directory1;
            break;
        case MapTab:
            [self.navigationController pushViewController:[MapViewController new] animated:YES];
            return;
            break;
        case NewsTab:
            baseViewController.controllerType = News;
            break;
        case TaxiTab:
            baseViewController.controllerType = Taxi;
            break;
        case DeliveryTab:
            baseViewController.controllerType = Delivery1;
            break;
        case PosterTab:
            baseViewController.controllerType = Poster1;
            break;
            
        default:
            return;
            break;
    }
    
    [self.navigationController pushViewController:[baseViewController init] animated:YES];
}

-(void)openSendController{
    [self.navigationController pushViewController:[SendMessageViewController new] animated:YES];
}

-(void)openBacket{
    BasketViewController *basketViewController = [BasketViewController sharedManager];
    
    if ([basketViewController countDishes] == 0) {
        return;
    }
    
    [self.navigationController pushViewController:basketViewController animated:YES];
}

@end
