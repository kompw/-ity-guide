//
//  FilterMapController.m
//  CityGuide
//
//  Created by Taras on 7/20/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "FilterMapController.h"
#import "FilterMapView.h"
#import "FilterMapCell.h"

#import "DownCategoriesModel.h"
#import "CategoriesModel.h"

static NSString *CellIdentifier = @"Cell";
#define  colorSelect() [UIColor colorWithRed:61/255.0f green:255/255.0f blue:247/255.0f alpha:1.0f]
#define  colorNotSelect() [UIColor lightGrayColor]

@interface FilterMapController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSouce;

@property UIImage *imageOpen;
@property UIImage *imageClose;
@end

@implementation FilterMapController

+ (FilterMapController *)sharedManager
{
    static FilterMapController *shaderManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shaderManager = [[FilterMapController alloc] init];
        shaderManager.dataSouce = [NSMutableArray new];
        shaderManager.imageOpen = [UIImage imageNamed:@"down_blue_x.png"];
        shaderManager.imageClose = [UIImage imageNamed:@"right_grey_x.png"];
    });
    return shaderManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Фильтр объектов на карте";
    [self.tableView registerNib:[UINib nibWithNibName:[FilterMapCell description] bundle:nil] forCellReuseIdentifier:CellIdentifier];
    FilterMapView *filterMapView = [[[NSBundle mainBundle] loadNibNamed:[FilterMapView description] owner:self options:nil] firstObject];
    self.tableView.sectionHeaderHeight = filterMapView.bounds.size.height;
    
    UIButton *filterB = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
    [filterB setTitle:@"Показать" forState:UIControlStateNormal];
    [filterB setTitleColor:colorSelect() forState:UIControlStateNormal];
    [filterB addTarget:self action:@selector(showMap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:filterB];
    
    if (self.dataSouce.count != 0) {
        return;
    }
    
    [ServerManager directory1Data:^(NSArray *array) {
        for (NSDictionary *dic in array) {
            CategoriesModel *categories = [CategoriesModel new];
            categories.name = dic[name_key];
            categories.catId = [dic[id_key] description];
            [self.dataSouce addObject:categories];
            [self.tableView reloadData];
        }
    }];
}

-(void)showMap{
    if (self.delegate && [self.delegate respondsToSelector:@selector(showMarkersWithData:)]) {
        NSMutableString *lineRequest = [NSMutableString new];
        
        for (CategoriesModel *categories in self.dataSouce) {
            for (DownCategoriesModel *downCategoriesModel in categories.downCategories) {
                if (downCategoriesModel.isSelect) {
                    [lineRequest appendFormat:@"%@,",downCategoriesModel.downCategoriesId];
                }
            }
        }
        
        if (lineRequest.length != 0) {
            [self.delegate showMarkersWithData:[lineRequest substringToIndex:[lineRequest length]-1]];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

#pragma UITableViewDelegate

- (void)didSelectSection:(UIButton*)sender {
    CategoriesModel *categoriesModel = self.dataSouce[sender.tag];

    if (categoriesModel.downCategories.count == 0) {
        [ServerManager directory2Data:categoriesModel.catId forMap:YES completion:^(NSArray *array) {
            for (NSDictionary *dic in array) {
                DownCategoriesModel *downCategoriesModel = [DownCategoriesModel new];
                downCategoriesModel.downCategoriesId = [dic[id_key] description];
                downCategoriesModel.name = dic[name_key];
                [categoriesModel.downCategories addObject:downCategoriesModel];
            }
            
            [self openRowsFor:sender.tag andStatus:categoriesModel.isOpen andHeader:(FilterMapView*)[sender superview]];
        }];
    }else{
        [self openRowsFor:sender.tag andStatus:categoriesModel.isOpen andHeader:(FilterMapView*)[sender superview]];
    }
}

-(void)openRowsFor:(NSInteger)section andStatus:(BOOL)isOpen andHeader:(FilterMapView*)header{
    CategoriesModel *categoriesModel = self.dataSouce[section];
    categoriesModel.isOpen = !isOpen;
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (int i=0; i < categoriesModel.downCategories.count; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
    
    if (isOpen) {
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    } else {
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    }
 
    header.arrow.image = !isOpen ? self.imageOpen : self.imageClose;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CategoriesModel *categoriesModel = self.dataSouce[section];
    
    FilterMapView *filterMapView = [[[NSBundle mainBundle] loadNibNamed:[FilterMapView description] owner:self options:nil] firstObject];
    filterMapView.button.tag = section;
    [filterMapView.button addTarget:self action:@selector(didSelectSection:) forControlEvents:UIControlEventTouchUpInside];
    filterMapView.title.text = categoriesModel.name;
    filterMapView.marker.backgroundColor = categoriesModel.isSelect ? colorSelect() : colorNotSelect();
    filterMapView.arrow.image = categoriesModel.isOpen ? self.imageOpen : self.imageClose;
    return filterMapView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSouce.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CategoriesModel *categoriesModel = self.dataSouce[section];
    if (categoriesModel.isOpen) {
        return categoriesModel.downCategories.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FilterMapCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:[FilterMapCell description] owner:self options:nil] firstObject];
    }
    
    CategoriesModel *categoriesModel = self.dataSouce[indexPath.section];
    NSMutableArray *downCategories = categoriesModel.downCategories;
    DownCategoriesModel *downCategoriesModel = downCategories[indexPath.row];
    cell.title.text = downCategoriesModel.name;
    cell.marker.backgroundColor = downCategoriesModel.isSelect ? colorSelect() : colorNotSelect();
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoriesModel *categoriesModel = self.dataSouce[indexPath.section];
    
    DownCategoriesModel *downCategoriesModel = categoriesModel.downCategories[indexPath.row];
    downCategoriesModel.isSelect = !downCategoriesModel.isSelect;
    
    NSArray *array =[categoriesModel.downCategories filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.isSelect == YES"]];
    categoriesModel.isSelect = array.count == 0 ? NO : YES;
    
    [tableView reloadData];
}

@end
