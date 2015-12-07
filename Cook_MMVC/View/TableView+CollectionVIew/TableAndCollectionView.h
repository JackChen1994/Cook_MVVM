//
//  TableAndCollectionView.h
//  Cook_MMVC
//
//  Created by tarena on 15/10/22.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableAndCollectionView : UIView

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) id<UITableViewDataSource,UICollectionViewDataSource,UITableViewDelegate,UICollectionViewDelegate> delegate;

- (void)showTableView;
- (void)showCollectionView;

@end
