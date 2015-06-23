//
//  BaseViewController.m
//  CityGuide
//
//  Created by taras on 23.06.15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "BaseViewController.h"

#import "SendView.h"
#import "MainMenuCell.h"
#import "TextCell.h"
#import "TextWithImageCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

static NSString *reuseIdentifier = @"cell";

typedef NS_ENUM(NSInteger, mainMenu) {
    SharesTab     = 0,
    DeliveryTab   = 1,
    DirectoryTab  = 2,
    MapTab        = 3,
    NewsTab       = 4,
    TaxiTab       = 5,
    PosterTab     = 6
};


@interface BaseViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation BaseViewController
@synthesize dataSource;

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = @[];
    
    switch (self.controllerType) {
        case MainMenu:{
            self.title = @"Главное меню";
            dataSource = [ServerManager getMainMenu];
            UIView * v = [[[NSBundle mainBundle] loadNibNamed:[MainMenuCell description] owner:self options:nil] firstObject];
            self.tableView.rowHeight = v.frame.size.height;
            [self.tableView registerNib:[UINib nibWithNibName:[MainMenuCell description] bundle:nil] forCellReuseIdentifier:reuseIdentifier];
        }
            break;
        case Shares:{
            self.title = @"Акции";
            UIView * v = [[[NSBundle mainBundle] loadNibNamed:[TextWithImageCell description] owner:self options:nil] firstObject];
            self.tableView.rowHeight = v.frame.size.height;
            [self.tableView registerNib:[UINib nibWithNibName:[TextWithImageCell description] bundle:nil] forCellReuseIdentifier:reuseIdentifier];
            
            SendView *sendView = [[[NSBundle mainBundle] loadNibNamed:[SendView description] owner:self options:nil] firstObject];
            self.tableView.sectionHeaderHeight = sendView.frame.size.height;
            self.tableView.tableHeaderView = sendView;
            
            [ServerManager sharesData:^(NSArray *array) {
                dataSource = array;
                [self.tableView reloadData];
            }];
        }
            break;
    
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataSource.count;
}
/*
- (UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    return (UITableViewHeaderFooterView *)view;
}
*/
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     NSDictionary *model = self.dataSource[indexPath.row];
     UITableViewCell *cell;

     switch (self.controllerType) {
         case MainMenu:{
             cell = [self mainMenuCell:indexPath andModel:model];
         }
             break;
         case Shares:{
             cell = [self textWithImageCell:indexPath andModel:model];
         }
             break;
             
         default:
             break;
     }
     

  return cell;
 }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.controllerType) {
        case MainMenu:{
            [self actionMainMenu:indexPath.row];
        }
            break;
        case Shares:{
            
        }
            break;
            
        default:
            break;
    }
}

#pragma action mainMenu 

-(void)actionMainMenu:(NSInteger)row{
    switch (row) {
        case SharesTab:{
            BaseViewController *baseViewController = [BaseViewController alloc];
            baseViewController.controllerType = Shares;
            [self.navigationController pushViewController:baseViewController animated:YES];
        }
            break;
        case DeliveryTab:
            
            break;
        case DirectoryTab:
            
            break;
        case MapTab:
            
            break;
        case NewsTab:
            
            break;
        case TaxiTab:
            
            break;
        case PosterTab:
            
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

-(UITableViewCell*)textWithImageCell:(NSIndexPath *)indexPath andModel:(NSDictionary*)model{
    TextWithImageCell* textWithImageCell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (textWithImageCell == nil) {
        textWithImageCell = [[[NSBundle mainBundle] loadNibNamed:[TextWithImageCell description] owner:self options:nil] firstObject];
    }
    textWithImageCell.title.text = model[title_key];
    [textWithImageCell.image sd_setImageWithURL:[NSURL URLWithString:model[image_key]]];
    
    
    return textWithImageCell;
}




@end
