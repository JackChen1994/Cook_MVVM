//
//  MainViewController.m
//  Cook_MMVC
//
//  Created by tarena on 15/11/27.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "MainViewController.h"
#import "ImageScrollerView.h"
#import "Masonry.h"
#import "MainViewModel.h"
#import "ColorManger.h"
#import "TableViewCell.h"
#import "MJChiBaoZiHeader.h"
#import "MJRefresh.h"
#import "DetailViewController.h"
#import "DetailViewModel.h"
#import "FoodListViewController.h"
#import "MiniSearchView.h"

NSString *const mainTableViewCellIdentifier = @"MainTableViewCell";

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate, MiniSearchDelegate>

@property (nonatomic, strong)ImageScrollerView *imageScrollView;

@property (nonatomic, strong)NSArray *imageURLs;

@property (nonatomic, strong)MainViewModel *mainViewModel;
@property (nonatomic, strong)UITableView *tableView;
@property (weak, nonatomic) IBOutlet MiniSearchView *miniSearchView;

@end

@implementation MainViewController

#define Duration 2.0

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.top.equalTo(self.view.mas_top);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }
    return _tableView;
}

- (MainViewModel *)mainViewModel {
    if (!_mainViewModel) {
        _mainViewModel = [[MainViewModel alloc]init];
    }
    return _mainViewModel;
}

- (void)setImageURLs:(NSArray *)imageURLs {
    _imageURLs = imageURLs;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.imageScrollView setImageURLs:_imageURLs duration: Duration];
    });
}

- (ImageScrollerView *)imageScrollView {
    if (!_imageScrollView) {
        _imageScrollView = [[ImageScrollerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.707)];
}
    return _imageScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.miniSearchView.delegate = self;
    [self.navigationController.navigationBar setBarTintColor:[ColorManger primaryColor]];
    self.navigationController.navigationBar.tintColor = [ColorManger textAndIconColor];
    [self initTableView];
    [self.tableView.header beginRefreshing];
}

- (void)initTableView {
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:mainTableViewCellIdentifier];
    self.tableView.tableHeaderView = self.imageScrollView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.header = [MJChiBaoZiHeader headerWithRefreshingBlock:^{
        //头视图
        [self.mainViewModel refreshHeadWithComplete:^(NSError *error) {
            self.imageURLs = [self.mainViewModel imageURLs];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView.header endRefreshing];
            });
        }];
        //场景
        [self.mainViewModel refreshSceneWithComplete:^(NSError *error) {
            TableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.imageURLs = [self.mainViewModel sceneImageURLs];
            cell.titles = [self.mainViewModel sceneTitles];
            cell.foodList = [self.mainViewModel sceneFoodList];
        }];
        //推荐
        [self.mainViewModel refreshRecommendWithComplete:^(NSError *error) {
            TableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            cell.imageURLs = [self.mainViewModel recommendImageURLs];
            cell.titles = [self.mainViewModel recommendTitles];
            cell.foodList = [self.mainViewModel recommendFoodList];
        }];
        //收藏
        [self.mainViewModel refreshFavoriteWithComplete:^(NSError *error) {
            TableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            cell.imageURLs = [self.mainViewModel favoritesImageURLs];
            cell.titles = [self.mainViewModel favoritesTitles];
            cell.foodList = [self.mainViewModel favoritesFoodList];
        }];
        
    }];
}

#pragma mark - Table View Data Source
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainTableViewCellIdentifier forIndexPath:indexPath];
    cell.myDelegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0 || indexPath.row == 1) {
        [cell handleControlEvent:UIControlEventTouchUpInside withBlock:^(id obj) {
            [self performSegueWithIdentifier:@"MainToList" sender:indexPath];
        }];
    }
    if (indexPath.row == 2) {
        [cell handleControlEvent:UIControlEventTouchDragInside withBlock:^(id obj) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tabBarController setSelectedIndex:2];
            });
        }];
    }
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = [self.mainViewModel scene];
            cell.imageURLs = [self.mainViewModel sceneImageURLs];
            cell.titles = [self.mainViewModel sceneTitles];
            cell.foodList = [self.mainViewModel sceneFoodList];
            break;
        case 1:
            cell.titleLabel.text = @"掌厨推荐";
            cell.imageURLs = [self.mainViewModel recommendImageURLs];
            cell.titles = [self.mainViewModel recommendTitles];
            cell.foodList = [self.mainViewModel recommendFoodList];
            break;
        case 2:
            cell.titleLabel.text = @"美食收藏";
            cell.imageURLs = [self.mainViewModel favoritesImageURLs];
            cell.titles = [self.mainViewModel favoritesTitles];
            cell.foodList = [self.mainViewModel favoritesFoodList];
            break;
        default:
            break;
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 8 + 27 + 8 + 2 + ((ScreenWidth - 8*3 - 4*2)/4 + 14)*2 + 4 + 4;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

#pragma mark - My Table Delegate
- (void)clickCollectionCell:(FoodModel *)foodModel {
    [self performSegueWithIdentifier:@"MainToDetail" sender:foodModel];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[FoodModel class]]) {
        DetailViewModel *detailViewModel = [[DetailViewModel alloc]initWithFoodModel:sender];
        DetailViewController *detailViewController = segue.destinationViewController;
        detailViewController.hidesBottomBarWhenPushed = YES;
        detailViewController.detailViewModel = detailViewModel;
    }
    if ([sender isKindOfClass:[NSIndexPath class]]) {
        NSIndexPath *indexPath = sender;
        FoodListViewController *foodListViewController = segue.destinationViewController;
        NSString *cid = @[[self.mainViewModel sceneCid],@"211"][indexPath.row];
        foodListViewController.foodListVM = [[FoodListViewModel alloc]initWithCid:cid];
    }
    if ([sender isKindOfClass:[NSString class]]) {
        FoodListViewController *foodListViewController = segue.destinationViewController;
        foodListViewController.foodListVM = [[FoodListViewModel alloc]initWithSearchText:sender];
    }
}

#pragma mark - Mini Search Delegate
- (void)didSearchWithText:(NSString *)text {
    
    [self performSegueWithIdentifier:@"MainToList" sender:text];
}
- (IBAction)clickSearchButton:(UIButton*)sender {
    
    [self performSegueWithIdentifier:@"MainToList" sender:self.miniSearchView.textField.text];
}

@end
