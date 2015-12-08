//
//  TableAndCollectionView.m
//  Cook_MMVC
//
//  Created by tarena on 15/10/22.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "TableAndCollectionView.h"
#import "Masonry.h"

#define DefaultInterval    10   //默认间距

@interface TableAndCollectionView()

@property (nonatomic, strong) UICollectionViewFlowLayout *collectionLayout;

@end

@implementation TableAndCollectionView

- (UICollectionViewFlowLayout *)collectionLayout {
    if (!_collectionLayout) {
        _collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionLayout.sectionInset = UIEdgeInsetsMake(DefaultInterval, DefaultInterval, DefaultInterval, DefaultInterval);
        _collectionLayout.itemSize = CGSizeMake((ScreenWidth-DefaultInterval*3)/2, (ScreenWidth-DefaultInterval*3)/2+30);
    }
    return _collectionLayout;
}

#pragma mark - 初始化
- (instancetype)initWithCollectionViewFlowLayout:(UICollectionViewFlowLayout *)collectionLayout{
    _collectionLayout = collectionLayout;
    return [self init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initTableView];
        [self initCollectionView];
    }
    return self;
}

- (void)setDelegate:(id<UITableViewDataSource,UICollectionViewDataSource,UITableViewDelegate,UICollectionViewDelegate>)delegate {
    _delegate = delegate;
    self.tableView.delegate = delegate;
    self.tableView.dataSource = delegate;
    self.collectionView.dataSource = delegate;
    self.collectionView.delegate = delegate;
}

- (void)awakeFromNib {
    [self initTableView];
    [self initCollectionView];
}

- (void)initTableView {
    self.tableView = [[UITableView alloc]init];
}

- (void)initCollectionView {
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.collectionLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 方法事件
- (void)showTableView {
    [self.collectionView removeFromSuperview];
    [self.tableView reloadData];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
}

- (void)showCollectionView {
    [self.tableView removeFromSuperview];
    [self.collectionView reloadData];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
}

@end
