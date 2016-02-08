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
#import "NewsDetailController.h"
#import "NewsController.h"
#import "SendNewPosterViewController.h"

#import "SendView.h"
#import "MainMenuCell.h"
#import "TextCell.h"
#import "TextWithImageCell.h"
#import "MainHeaderView.h"
#import "TaxiCell.h"
#import "Poster3Cell.h"

#import <SDWebImage/UIImageView+WebCache.h>

static NSString *reuseIdentifier = @"cell";

//all tab in main menu
typedef NS_ENUM(NSInteger, mainMenu) {
    SharesTab     = 1,
    DirectoryTab  = 2,
    MapTab        = 3,
    NewsTab       = 4,
    TaxiTab       = 5,
    DeliveryTab   = 6,
    PosterTab     = 7
};


@interface BaseTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@property MainHeaderView *mainHeaderView;
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
            
            self.mainHeaderView = [[[NSBundle mainBundle] loadNibNamed:[MainHeaderView description] owner:self options:nil] firstObject];
            self.mainHeaderView.navigationController = self.navigationController;
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
            UIView * v = [[[NSBundle mainBundle] loadNibNamed:[TextWithImageCell description] owner:self options:nil] firstObject];
            self.tableView.rowHeight = v.frame.size.height;
            [self.tableView registerNib:[UINib nibWithNibName:[TextWithImageCell description] bundle:nil] forCellReuseIdentifier:reuseIdentifier];
            
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
       
        case Taxi:{
            self.title = @"Такси";
            UIView * v = [[[NSBundle mainBundle] loadNibNamed:[TaxiCell description] owner:self options:nil] firstObject];
            self.tableView.rowHeight = v.frame.size.height;
            [self.tableView registerNib:[UINib nibWithNibName:[TaxiCell description] bundle:nil] forCellReuseIdentifier:reuseIdentifier];
            
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
            UIView * v = [[[NSBundle mainBundle] loadNibNamed:[TextWithImageCell description] owner:self options:nil] firstObject];
            self.tableView.rowHeight = v.frame.size.height;
            [self.tableView registerNib:[UINib nibWithNibName:[TextWithImageCell description] bundle:nil] forCellReuseIdentifier:reuseIdentifier];
            
            SendView *sendView = [[[NSBundle mainBundle] loadNibNamed:[SendView description] owner:self options:nil] firstObject];
            self.tableView.sectionHeaderHeight = sendView.frame.size.height;
   
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
            [self.tableView registerNib:[UINib nibWithNibName:[Poster3Cell  description] bundle:nil] forCellReuseIdentifier:reuseIdentifier];
            self.tableView.estimatedRowHeight = 86;
            self.tableView.rowHeight = UITableViewAutomaticDimension;
            
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
    
    switch (self.controllerType) {
        case MainMenu:
        case Directory2:
        case Directory3:
        case Poster2:
        case Poster3:
            return nil;
            break;
   
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
        case Poster1:
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
             if (indexPath.row == 0) {
                 static NSString *Identifier = @"main";
                 cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
                 if (cell == nil) {
                     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
                     [cell addSubview:self.mainHeaderView];
                     cell.bounds = self.mainHeaderView.bounds;
                 }
                 
                 return cell;
             }else
                cell = [self mainMenuCell:indexPath andModel:model];
         }
             break;
             
         case Shares:{
             cell = [self textWithImageCell:indexPath andTitle:model[title_key] andImageUrl:model[image_key]];
         }
             break;
             
         case Delivery2:
             cell = [self textCell:indexPath andModel:model];
             break;
         
         case Taxi:{
             TaxiCell* textWithImageCell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
             if (textWithImageCell == nil) {
                 textWithImageCell = [[[NSBundle mainBundle] loadNibNamed:[TaxiCell description] owner:self options:nil] firstObject];
             }
             [textWithImageCell setDataWithDictionary:model];
             cell = textWithImageCell;
         }
             break;
             
         case Poster3:{
             Poster3Cell* textWithImageCell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
             if (textWithImageCell == nil) {
                 textWithImageCell = [[[NSBundle mainBundle] loadNibNamed:[Poster3Cell description] owner:self options:nil] firstObject];
             }
             [textWithImageCell setDataWithDictionary:model];
             cell = textWithImageCell;
         }
             break;
             
         case Delivery3:
         case Delivery1:
         case Directory3:{
             cell = [self textWithImageCell:indexPath andTitle:model[name_key] andImageUrl:model[image_key]];
         }
             break;
             
        case Poster1:
        case Directory1:
        case Directory2:
             cell = [self textWithImageCell:indexPath andTitle:model[name_key] andImageUrl:model[image_key]];
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
             break;
             
        case Poster2:
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.controllerType == MainMenu && indexPath.row == 0) {
        return self.mainHeaderView.bounds.size.height;
    }
    
    return tableView.rowHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *model = self.dataSource[indexPath.row];
    
    switch (self.controllerType) {
        case MainMenu:{
            if (indexPath.row == 0) {
                break;
            }
            [self actionMainMenu:indexPath.row];
        }
            break;
            
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

#pragma - mark configure cell

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

#pragma - mark action mainMenu

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
        case NewsTab:
            [self.navigationController pushViewController:[NewsController new] animated:YES];
            return;
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
    if (self.controllerType == Poster1 || self.controllerType ==  Poster2 || self.controllerType == Poster3) {
        [self.navigationController pushViewController:[SendNewPosterViewController new] animated:YES];
        return;
    }
    
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
