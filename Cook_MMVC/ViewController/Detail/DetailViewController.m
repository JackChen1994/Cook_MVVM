//
//  DetailViewController.m
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailHeaderView.h"
#import "DetailStepCell.h"
#import "ColorManger.h"

NSString *const detailCellIdentifier = @"DetailCell";

@interface DetailViewController ()<UITableViewDataSource, UITableViewDelegate, DetailHeadViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DetailHeaderView *headView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = [self.detailViewModel title];
    
    [self initTableView];
    
    [self initHeadView];
    
    [self headViewData];

}

#pragma mark - 初始化
- (void)initTableView {
    
    CGRect tableFrame = self.view.bounds;
    //去掉导航栏和navigation bar 的高度
    tableFrame.size.height -= [[UIApplication sharedApplication] statusBarFrame].size.height +self.navigationController.navigationBar.bounds.size.height;
    
    self.tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [ColorManger primaryColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailStepCell" bundle:nil] forCellReuseIdentifier:detailCellIdentifier];
    
    [self.view addSubview:self.tableView];
    
}

- (void)initHeadView {
    //从xib初始化headView
    self.headView = [[NSBundle mainBundle] loadNibNamed:@"DetailHeaderView" owner:self options:nil].firstObject;
    //设置Frame, height取决于label的height
    CGRect frame = self.view.bounds;
    
    CGSize maximumLabelSize = CGSizeMake(self.tableView.bounds.size.width - 14.0 * 2, FLT_MAX);
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:16]};
    //计算文字的rect
    CGRect rect = [[self.detailViewModel intro] boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    frame.size.height = (self.view.bounds.size.width - 50*2) + 10 + 5 + 8*2 + rect.size.height;
    
    self.headView.frame = frame;
    //添加headView
    self.tableView.tableHeaderView = self.headView;
    //设置代理
//    self.headView.delegate = self;
    //使用Block回调
    [self.headView handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        if (![self.headView isButtonSelected]) {
            [self.detailViewModel cache];
        }else {
            [self.detailViewModel deCache];
        }
        [self setHeadViewButtonSelected];
    }];
}

- (void)headViewData {
    [self.headView.headImageView sd_setImageWithURL:[NSURL URLWithString:[self.detailViewModel imageURLString]] placeholderImage:[UIImage imageNamed:@"quan01"]];
    self.headView.headLabelView.text = [self.detailViewModel intro];
    [self setHeadViewButtonSelected];
}

- (void)setHeadViewButtonSelected {
    [self.headView setButtonSelected:[self.detailViewModel isCached]];
}

#pragma mark Table View DateSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.detailViewModel.foodModel.steps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailStepCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCellIdentifier forIndexPath:indexPath];
    [cell.stepImageView sd_setImageWithURL:[NSURL URLWithString:[self.detailViewModel stepImageAtIndexPath:indexPath]] placeholderImage:[UIImage imageNamed:@"quan01"]];
    cell.stepTitleLabel.text = [self.detailViewModel stepTitleAtIndexPath:indexPath];
    
    return cell;    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat imageHeight = 135;
    
    CGSize maximumLabelSize = CGSizeMake(self.tableView.bounds.size.width - 10.0 * 2, FLT_MAX);
    
    //这里的字体比显示的字体大一号,留一点空间给label
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:18]};
    
    CGRect rect = [[self.detailViewModel stepTitleAtIndexPath:indexPath] boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    return imageHeight + rect.size.height + 8.0 * 3;
}

#pragma mark Table View Delegate

#pragma mark Detail Head View Delegate
- (void)clickButton {
    [self.detailViewModel cache];
    [self setHeadViewButtonSelected];
}

@end
