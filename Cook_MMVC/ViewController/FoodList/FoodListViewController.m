//
//  FoodListViewController.m
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "FoodListViewController.h"
#import "TableAndCollectionView.h"
#import "FoodListTableCell.h"
#import "FoodListCollectionCell.h"
#import "MJChiBaoZiFooter2.h"
#import "MJChiBaoZiHeader.h"
#import "DetailViewController.h"
#import "ColorManger.h"
#import "MJRefresh.h"
#import "MiniSearchView.h"
#import "Masonry.h"

NSString *const foodTableCellIdentifier = @"FoodTableCell";
NSString *const foodCellectionIdentifier = @"FoodCollectionCell";

@interface FoodListViewController ()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, MiniSearchDelegate>
@property (weak, nonatomic) IBOutlet TableAndCollectionView *tableAndCollectionView;
@property (nonatomic, assign) BOOL isList;

@property (weak, nonatomic) IBOutlet MiniSearchView *miniSearchView;
@property (weak, nonatomic) IBOutlet MiniSearchView *miniSearchHeight;

@end

@implementation FoodListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.miniSearchView.delegate = self;
    //添加右按钮
    [self addRightButtonItem];
    //初始化主界面
    [self initMainView];
}

#pragma mark - 界面初始化
- (void)initMainView {
    self.tableAndCollectionView.delegate = self;
    [self.tableAndCollectionView.tableView registerNib:[UINib nibWithNibName:@"FoodListTableCell" bundle:nil] forCellReuseIdentifier:foodTableCellIdentifier];
    [self.tableAndCollectionView.collectionView registerNib:[UINib nibWithNibName:@"FoodListCollectionCell" bundle:nil] forCellWithReuseIdentifier:foodCellectionIdentifier];
    //添加MJRefreshFooter和header
    self.tableAndCollectionView.tableView.footer = [MJChiBaoZiFooter2 footerWithRefreshingBlock:^{
        [self.foodListVM getMoreFoodListCompleteWithError:^(NSError *error) {
            [self.tableAndCollectionView.tableView.footer endRefreshing];
            [self refresh];
        }];
    }];
    
    self.tableAndCollectionView.tableView.header = [MJChiBaoZiHeader headerWithRefreshingBlock:^{
        [self.foodListVM refreshFoodListCompleteWithError:^(NSError *error) {
            [self.tableAndCollectionView.tableView.header endRefreshing];
            [self refresh];
        }];
    }];
    self.tableAndCollectionView.collectionView.footer = [MJChiBaoZiFooter2 footerWithRefreshingBlock:^{
        [self.foodListVM getMoreFoodListCompleteWithError:^(NSError *error) {
            [self.tableAndCollectionView.collectionView.footer endRefreshing];
            [self refresh];
        }];
    }];
    
    self.tableAndCollectionView.collectionView.header = [MJChiBaoZiHeader headerWithRefreshingBlock:^{
        [self.foodListVM refreshFoodListCompleteWithError:^(NSError *error) {
            [self.tableAndCollectionView.collectionView.header endRefreshing];
            [self refresh];
        }];
    }];
    //加载初始数据
    [self refresh];
    [self.tableAndCollectionView.collectionView.header beginRefreshing];
 }

- (void)addRightButtonItem {
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setBackgroundImage:[UIImage imageNamed:@"navi_list_w"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"navi_collection_w"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(clickRightBarButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)clickRightBarButton:(UIButton *) sender{
    sender.selected = !sender.selected;
    self.isList = sender.selected;
    [self refresh];
}

#pragma mark - 界面刷新 
- (void)refresh {
    if (self.isList) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableAndCollectionView showTableView];
        });
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableAndCollectionView showCollectionView];
        });
    }
}

#pragma mark - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.foodListVM.foodList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FoodListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:foodTableCellIdentifier forIndexPath:indexPath];
    //设置gif,方法已跪,1⃣️加载图片后,会被gif顶掉,2⃣️在选中cell时,gif MISS
    //加载网络图片
    [cell.foodImageView sd_setImageWithURL:[NSURL URLWithString:[self.foodListVM imageUrlStringAtIndexPath:indexPath]] placeholderImage:[UIImage imageNamed:@"quan01"]];
    //加载标题
    cell.foodTitle.text = [self.foodListVM titleAtIndexPath:indexPath];
    cell.foodIntroLabel.text = [self.foodListVM introAtIndexPath:indexPath];
    cell.foodIntroLabel.textColor = [ColorManger secondaryTextColor];
    
    return cell;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"ListToDetail" sender:indexPath];
}

#pragma mark - Collection View Data Source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.foodListVM.foodList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FoodListCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:foodCellectionIdentifier forIndexPath:indexPath];
    
    [cell.foodImageView sd_setImageWithURL:[NSURL URLWithString:[self.foodListVM imageUrlStringAtIndexPath:indexPath]] placeholderImage:[UIImage imageNamed:@"quan01"]];
    cell.foodTitle.text = [self.foodListVM titleAtIndexPath:indexPath];
    
    return cell;
}
#pragma mark - Collection View Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"ListToDetail" sender:indexPath];
}

#pragma mark -  推出0
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[NSIndexPath class]]) {
        DetailViewModel *detailViewModel = [[DetailViewModel alloc]initWithFoodModel:[self.foodListVM foodModelAtIndexPath:sender]];
        DetailViewController *detailViewController = segue.destinationViewController;
        detailViewController.hidesBottomBarWhenPushed = YES;
        detailViewController.detailViewModel = detailViewModel;
    }
}

#pragma mark - MiniSearchDelegate
- (void)didSearchWithText:(NSString *)text {
    [self.foodListVM searchWithText:text completeWithError:^(NSError *error) {
        if (error) {
            NSLog(@"%@",error.userInfo);
        }else {
            [self refresh];
        }
    }];
}

@end