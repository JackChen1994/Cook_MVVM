//
//  CategoryVIewController.m
//  Cook_MMVC
//
//  Created by tarena on 15/10/26.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "CategoryVIewController.h"
#import "MainCategoryViewModel.h"
#import "SubCategoryViewModel.h"
#import "CategoryTableCell.h"
#import "CategoryCollectionCell.h"
#import "ColorManger.h"
#import "FoodListViewController.h"
#import "MiniSearchView.h"

NSString *const categoryTableViewCellIdentifier = @"CategoryTableCell";
NSString *const categoryCollectionViewCellIdentifier = @"CategoryCollectionCell";

@interface CategoryVIewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, MiniSearchDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet MiniSearchView *miniSearchView;

@property (nonatomic, strong) MainCategoryViewModel *mainCategoryViewModel;
@property (nonatomic, strong) SubCategoryViewModel *subCategoryViewModel;

@end

@implementation CategoryVIewController

- (MainCategoryViewModel *)mainCategoryViewModel {
    if (!_mainCategoryViewModel) {
        _mainCategoryViewModel  = [[MainCategoryViewModel alloc]init];
    }
    return _mainCategoryViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"全部分类";
    self.miniSearchView.delegate = self;
    
    //注册cell重用
    [self.tableView registerNib:[UINib nibWithNibName:@"CategoryTableCell" bundle:nil] forCellReuseIdentifier:categoryTableViewCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CategoryCollectionCell" bundle:nil] forCellWithReuseIdentifier:categoryCollectionViewCellIdentifier];
    //设置颜色
    self.tableView.backgroundColor = [ColorManger lightPrimaryColor];
    self.tableView.separatorColor = [ColorManger backGroundColor];
    self.collectionView.backgroundColor = [ColorManger backGroundColor];
    [self.navigationController.navigationBar setBarTintColor:[ColorManger primaryColor]];
    self.navigationController.navigationBar.tintColor = [ColorManger textAndIconColor];
    //设置navigation Title
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjects:@[[ColorManger textAndIconColor], [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0]] forKeys:@[NSForegroundColorAttributeName, NSFontAttributeName]]];
    [[UIApplication sharedApplication] setValue:[NSNumber numberWithInteger:UIStatusBarStyleLightContent] forKey:@"statusBarStyle"];
    
    [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

#pragma mark - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.mainCategoryViewModel.categoryList.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryTableCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryTableViewCellIdentifier forIndexPath:indexPath];
    //设置文本
    cell.titleLabel.text = [self.mainCategoryViewModel nameAtIndexPath:indexPath];
    //设置颜色
    cell.backgroundColor = [ColorManger lightPrimaryColor];
    cell.titleLabel.textColor = [ColorManger darkPrimaryColor];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [ColorManger backGroundColor];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
    {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //加载subModel数据
    self.subCategoryViewModel = [self.mainCategoryViewModel subCategoryAtIndexPath:indexPath];
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    //界面刷新
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

#pragma mark - Collection View Data Source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.subCategoryViewModel.subCategoryList.subCategories.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:categoryCollectionViewCellIdentifier forIndexPath:indexPath];
    NSDictionary *dic = [self formatString:[self.subCategoryViewModel nameAtIndexPath:indexPath]];
    cell.titleLabel.font = [UIFont systemFontOfSize:[dic[@"fontSize"] floatValue]];
    cell.titleLabel.text = dic[@"string"];
    cell.titleLabel.textColor = [ColorManger textAndIconColor];
    cell.backgroundColor = [ColorManger primaryColor];
    return cell;
}

#pragma mark - Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"CategoryToList" sender:indexPath];
}

#pragma mark - 推出list

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[NSIndexPath class]]) {
        FoodListViewController *foodListViewController = segue.destinationViewController;
        NSString *cid = [self.subCategoryViewModel idAtIndexPath:sender];
        foodListViewController.foodListVM = [[FoodListViewModel alloc]initWithCid:cid];
    }
    if ([sender isKindOfClass:[NSString class]]) {
        FoodListViewController *foodListViewController = segue.destinationViewController;
        foodListViewController.foodListVM = [[FoodListViewModel alloc]initWithSearchText:sender];
    }
}

#pragma mark - Mini Search Delegate

- (void)didSearchWithText:(NSString *)text {
    
    [self performSegueWithIdentifier:@"CategoryToList" sender:text];
}

#pragma mark - 字体格式化
- (NSDictionary *)formatString:(NSString *) string{
    NSMutableString *formatString = [NSMutableString stringWithString:string];
   CGFloat fontSize = 20;
    switch (string.length) {
        case 1:
            fontSize = 30;
            break;
        case 2:
            fontSize = 23;
            break;
        case 3:
            fontSize = 19;
            break;
        case 4:
        case 5:
            fontSize = 19;
            [formatString insertString:@"\n" atIndex:2];
            break;
        case 6:
            fontSize = 19;
            [formatString insertString:@"\n" atIndex:3];
            break;
        default:
            
            switch ([self convertToInt:string]) {
                case 4:
                    fontSize = 23;
                    break;
                case 5:
                case 6:
                    fontSize = 19;
                    break;
                case 7:
                case 8:
                case 9:
                case 10:
                    fontSize = 19;
                    break;
                default:
                    fontSize = 15.1;
                    break;
            }
            break;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[NSString stringWithFormat:@"%f", fontSize-2] forKey:@"fontSize"];
    [dic setValue:[formatString copy] forKey:@"string"];
    
    return dic;
}

- (int)convertToInt:(NSString*)strtemp//判断中英混合的的字符串长度
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
        
    }
    return strlength;
}
@end
