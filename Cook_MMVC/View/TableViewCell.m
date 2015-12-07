//
//  TableViewCell.m
//  Cook_MMVC
//
//  Created by tarena on 15/11/30.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "TableViewCell.h"
#import "ColorManger.h"
#import "MainCollectionCell.h"
#import <objc/runtime.h>

NSString *const mainCollectionCellIdentifier = @"MainCollectionCell";

@implementation TableViewCell

- (void)setFoodList:(NSArray *)foodList {
    _foodList = foodList;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (void)awakeFromNib {
    //背景色
    self.lineView.backgroundColor = [ColorManger lightPrimaryColor];
    self.collectionView.backgroundColor = [ColorManger textAndIconColor];
    //设置不能滚动
    self.collectionView.scrollEnabled = NO;
    //设置cell布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(4, 4, 4, 4);
    flowLayout.minimumInteritemSpacing = 8;
    flowLayout.minimumLineSpacing = 8;
    flowLayout.itemSize = CGSizeMake((ScreenWidth - 8*3 - 4*2)/4, (ScreenWidth - 8*3 - 4*2)/4+14);
    [self.collectionView setCollectionViewLayout:flowLayout animated:NO];
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"MainCollectionCell" bundle:nil] forCellWithReuseIdentifier:mainCollectionCellIdentifier];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Collection View Data Source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell* )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:mainCollectionCellIdentifier forIndexPath:indexPath];
    if (self.foodList.count >= 8) {
        [cell.foodImageView sd_setImageWithURL:self.imageURLs[indexPath.row] placeholderImage:[UIImage imageNamed:@"quan01"]];
        cell.titleLabel.text = self.titles[indexPath.row];
    }
    return cell;
}

#pragma mark - Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.myDelegate clickCollectionCell:self.foodList[indexPath.row]];
}

#pragma mark - 给button加block

static char overviewKey;

- (void)handleControlEvent:(UIControlEvents)controlEvent withBlock:(void (^)(id obj))block {
    objc_setAssociatedObject(self, &overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self.button addTarget:self action:@selector(callActionBlock:) forControlEvents:controlEvent];
}

- (void)callActionBlock:(id)sender {
    void(^block)(id) = (void (^)(id))objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block(nil);
    }
}

@end
