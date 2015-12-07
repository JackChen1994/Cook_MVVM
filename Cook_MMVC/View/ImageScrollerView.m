//
//  ImageScrollerView.m
//  Cook_MMVC
//
//  Created by tarena on 15/11/27.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "ImageScrollerView.h"
#import "Masonry.h"
#import "ColorManger.h"

@interface ImageScrollerView()<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *scrollerView;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, assign)NSInteger current;
@property (nonatomic, assign)NSInteger maxCurrent;

@property (nonatomic, assign)NSTimer *timer;
@end

@implementation ImageScrollerView

- (UIScrollView *)scrollerView {
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc]initWithFrame:self.bounds];
        [self addSubview:_scrollerView];
        [_scrollerView setDelegate:self];
    }
    return _scrollerView;
}

+ (instancetype)imageScrollerViewWithImageURLs:(NSArray *)imageURLs {
    
    return [ImageScrollerView imageScrollerViewWithImageURLs:imageURLs duration:1];
}

+ (instancetype)imageScrollerViewWithImageURLs:(NSArray *)imageURLs duration:(CGFloat )duration {
    
    return [[ImageScrollerView alloc]initWithImageURLs:imageURLs duration:duration];
}

- (instancetype)initWithImageURLs:(NSArray *)imageURLs duration:(CGFloat )duration {
    self = [super init];
    if (self) {
        [self setImageURLs:imageURLs duration:duration];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)runPage {
    float width = self.scrollerView.frame.size.width;
    if (self.current == self.maxCurrent) {
        self.current = 0;
        [self.scrollerView setContentOffset:CGPointMake(self.current * width, 0) animated:NO];
    }
    self.current ++;
    dispatch_main_async_safe(^(void){
        [self.scrollerView setContentOffset:CGPointMake(self.current * width, 0) animated:YES];
    });
}

- (void)changePage {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_pageControl setCurrentPage:labs((int)(scrollView.contentOffset.x/self.frame.size.width)%self.maxCurrent)];
}

- (void)setImageURLs:(NSArray *) imageURLs duration:(NSInteger) duration {
    self.maxCurrent = imageURLs.count;
    float width = self.scrollerView.frame.size.width;
    float height = self.scrollerView.frame.size.height;
    self.scrollerView.contentSize = CGSizeMake((imageURLs.count + 1) * imageURLs.count, height);
    //设置图片
    [self.pageControl removeFromSuperview];
    for (int i=0; i<imageURLs.count+1; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * width, 0, width, height)];
        [imageView sd_setImageWithURL:imageURLs[i%imageURLs.count] placeholderImage:[UIImage imageNamed:@"quan01"]];
        [self.scrollerView addSubview:imageView];
        self.scrollerView.pagingEnabled = YES;
        self.scrollerView.userInteractionEnabled = YES;
    }
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, height - 44,width, 20)];
    //设置页面的数量
    [_pageControl setNumberOfPages:imageURLs.count];
    //        [_pageControl setHidesForSinglePage:YES];
    _pageControl.userInteractionEnabled = NO;
    //监听页面是否发生改变
    [_pageControl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
    //设置颜色
    [_pageControl setCurrentPageIndicatorTintColor:[ColorManger darkPrimaryColor]];
    [self addSubview:_pageControl];
    [self.scrollerView reloadInputViews];
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(runPage) userInfo:nil repeats:YES];
    }
}

@end
