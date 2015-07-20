//
//  NewsController.m
//  CityGuide
//
//  Created by Taras on 7/20/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "NewsController.h"
#import "NewsCollectionCell.h"
#import "NewsDetailController.h"

#import "NewsCollectionCell.h"
#import "SendView.h"

#import <SDWebImage/UIImageView+WebCache.h>

static NSString *reuseIdentifier = @"cell";

@interface NewsController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *senderButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation NewsController
@synthesize dataSource;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Новости";
    self.navigationItem.rightBarButtonItem = [AppManager plusButton:self andSelector:@selector(openSendController)];
    [AppManager roundMyView:self.senderButton borderRadius:5 borderWidth:0 color:nil];
    [self.senderButton addTarget:self action:@selector(openSendController) forControlEvents:UIControlEventTouchUpInside];

    [self.collection registerNib:[UINib nibWithNibName:[NewsCollectionCell description] bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    //set setting collection
  
    [ServerManager newsData:^(NSArray *array) {
        dataSource = array;
        [self.collection reloadData];
    }];
}

#pragma UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
///[self textWithImageCell:indexPath andTitle:model[title_key] andImageUrl:model[image_key]];
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataSource.count;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.bounds.size.width/2-2, 300);
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *model = self.dataSource[indexPath.row];
    
    NewsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.title.text = model[title_key];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model[image_key]]];
    cell.describe.text =  model[details_key];
    cell.time.text = model[date_key];
    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *model = self.dataSource[indexPath.row];
    NewsDetailController *newsDetailController = [NewsDetailController alloc];
    newsDetailController.souceDictionary = model;
    [self.navigationController pushViewController:[newsDetailController init] animated:YES];
}

-(void)openSendController{
    [self.navigationController pushViewController:[SendMessageViewController new] animated:YES];
}

@end
