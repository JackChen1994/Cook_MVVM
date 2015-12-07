//
//  FavoritesViewController.m
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "FavoritesViewController.h"
#import "TableAndCollectionView.h"
#import "FoodListTableCell.h"
#import "FoodListCollectionCell.h"
#import "MJChiBaoZiFooter2.h"
#import "MJChiBaoZiHeader.h"
#import "DetailViewController.h"
#import "FavoritesViewModel.h"
#import "DetailViewController.h"
#import "ColorManger.h"
#import "MJRefresh.h"


NSString *const favoritesTableCellIdentifier = @"FavoritesTableCell";
NSString *const favoritesCollectionCellIdentifier = @"FavoritesCollectionCell";

@interface FavoritesViewController ()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet TableAndCollectionView *tableAndCollectionView;
@property (nonatomic, assign) BOOL isList;
@property (nonatomic, strong) FavoritesViewModel *favoritesVM;

@end

@implementation FavoritesViewController

- (FavoritesViewModel *)favoritesVM {
    if (!_favoritesVM) {
        _favoritesVM = [[FavoritesViewModel alloc]init];
    }
    return _favoritesVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"收藏";
    //top颜色
    [self.navigationController.navigationBar setBarTintColor:[ColorManger primaryColor]];
    self.navigationController.navigationBar.tintColor = [ColorManger textAndIconColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjects:@[[ColorManger textAndIconColor], [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0]] forKeys:     @[NSForegroundColorAttributeName, NSFontAttributeName]]];
    [[UIApplication sharedApplication] setValue:[NSNumber numberWithInteger:UIStatusBarStyleLightContent] forKey:@"statusBarStyle"];
    //添加右按钮
    [self addRightButtonItem];
    //初始化主界面
    [self initMainView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refresh];
    [self.tableAndCollectionView.collectionView.header beginRefreshing];
    [self.tableAndCollectionView.tableView.header beginRefreshing];
}

#pragma mark - 界面初始化
- (void)initMainView {
    self.tableAndCollectionView.delegate = self;
    [self.tableAndCollectionView.tableView registerNib:[UINib nibWithNibName:@"FoodListTableCell" bundle:nil] forCellReuseIdentifier:favoritesTableCellIdentifier];
    [self.tableAndCollectionView.collectionView registerNib:[UINib nibWithNibName:@"FoodListCollectionCell" bundle:nil] forCellWithReuseIdentifier:favoritesCollectionCellIdentifier];
    //添加MJRefreshHeader
    self.tableAndCollectionView.tableView.header = [MJChiBaoZiHeader headerWithRefreshingBlock:^{
        [self.favoritesVM getCacheFoodListCompleteWithError:^(NSError *error) {
            [self.tableAndCollectionView.tableView.header endRefreshing];
            [self refresh];
        }];
    }];
    
    self.tableAndCollectionView.collectionView.header = [MJChiBaoZiHeader headerWithRefreshingBlock:^{
        [self.favoritesVM getCacheFoodListCompleteWithError:^(NSError *error) {
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
    
    return self.favoritesVM.foodList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FoodListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:favoritesTableCellIdentifier forIndexPath:indexPath];
    //设置gif,方法已跪,1⃣️加载图片后,会被gif顶掉,2⃣️在选中cell时,gif MISS
    //加载网络图片
    [cell.foodImageView sd_setImageWithURL:[NSURL URLWithString:[self.favoritesVM imageURLStringAtIndexPath:indexPath]] placeholderImage:[UIImage imageNamed:@"quan01"]];
    //加载标题
    cell.foodTitle.text = [self.favoritesVM titleAtIndexPath:indexPath];
    cell.foodIntroLabel.text = [self.favoritesVM introAtIndexPath:indexPath];
    cell.foodIntroLabel.textColor = [ColorManger secondaryTextColor];
    
    return cell;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"FavoritesToDetail" sender:indexPath];
}


#pragma mark - Collection View Data Source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.favoritesVM.foodList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FoodListCollectionCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:favoritesCollectionCellIdentifier forIndexPath:indexPath];
    //加载网络图片
    [cell.foodImageView sd_setImageWithURL:[NSURL URLWithString:[self.favoritesVM imageURLStringAtIndexPath:indexPath]] placeholderImage:[UIImage imageNamed:@"quan01"]];
    //加载标题
    cell.foodTitle.text = [self.favoritesVM titleAtIndexPath:indexPath];
    
    return cell;
}
#pragma mark - Collection View Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"FavoritesToDetail" sender:indexPath];
}

#pragma mark -  推出
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([sender isKindOfClass:[NSIndexPath class]]) {
        DetailViewModel *detailViewModel = [[DetailViewModel alloc]initWithFoodModel:[self.favoritesVM foodModelAtIndexPath:sender]];
        DetailViewController *detailViewController = segue.destinationViewController;
        detailViewController.hidesBottomBarWhenPushed = YES;
        detailViewController.detailViewModel = detailViewModel;
    }
}


@end
