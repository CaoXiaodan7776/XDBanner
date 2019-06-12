//
//  DKPhotoLoopView.m
//  DKPhotoLooop_Demo
//
//  Created by DoubleK on 2016/11/30.
//  Copyright © 2016年 DoubleK. All rights reserved.
//

#import "DKPhotoLoopView.h"
#import "DKCycleCollectionCell.h"

#define kDKCycleCollectionCellIdentify  @"DKCycleCollectionCellIdentify"

@interface DKPhotoLoopView()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    NSInteger _count;                   //照片数
    NSTimer *_timer;                    //定时器
    NSInteger _index;
    BOOL _isScroll;                     //标识   判断是否滚动到第三组第一个
    NSTimeInterval _timeInterval;       //默认是2s
    
}


@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation DKPhotoLoopView

- (id)initWithFrame:(CGRect)frame withImgsArr:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _timeInterval = 2;
        self.imgsArr = array;
        if (array.count > 0) {
            [self createUI];
        }
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame withImgsArr:(NSArray *)array timeInterval:(NSTimeInterval)timeInterval
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _timeInterval = timeInterval;
        self.imgsArr = array;
        [self createUI];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    _count = _imgsArr.count;
    _index = 0;
    self.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = self.bounds.size;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerClass:[DKCycleCollectionCell class] forCellWithReuseIdentifier:kDKCycleCollectionCellIdentify];
    _collectionView = collectionView;
    [self addSubview:collectionView];
    
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame)- 150)/2, CGRectGetHeight(self.frame) - 40, 150, 40)];
    pageControl.numberOfPages = _count;
    pageControl.currentPage = 0;
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:1 alpha:0.4];
    _pageControl = pageControl;
    [self addSubview:_pageControl];
    
    if (_count > 0) {
        //滑动到指定位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:1];
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        [self startTimer];
    }
}

- (void)setImgsArr:(NSArray<YFBannerModel *> *)imgsArr {
    _imgsArr = imgsArr;
    if (_imgsArr.count) {
        _count = _imgsArr.count;
        _index = 0;
        _pageControl.numberOfPages = _count;
        _pageControl.currentPage = 0;
        [_collectionView reloadData];
        //滑动到指定位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:1];
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        [self startTimer];
        
    }
}
#pragma mark -- Timer Action
- (void)cycleAction
{
    if (_index == _count) {
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:2] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        _pageControl.currentPage = 0;
        _index = 1;
        _isScroll = YES;
        
    }
    else
    {
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_index inSection:1] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        _pageControl.currentPage = _index;
        _index ++;
    }
}

- (void)startTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(cycleAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}


#pragma mark --UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _count;
}

- (DKCycleCollectionCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DKCycleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDKCycleCollectionCellIdentify forIndexPath:indexPath];
    cell.imgsArr = self.imgsArr;
    cell.indexPath = indexPath;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击第%ld个单元格",indexPath.row);
//    ChildrenOutModel *model = [self.imgsArr objectAtIndexSafe:indexPath.row];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(loopView:didSelectItemAtIndexPath:)]) {
        [self.delegate loopView:self didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //判断是否滚动到第三组第一个
    if (_isScroll) {
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        _isScroll = NO;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    currentPage = currentPage % _count;   //求余
    _pageControl.currentPage = currentPage;
    _index = currentPage;
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_index inSection:1] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (void)dealloc
{
    [_timer invalidate];
    _timer = nil;
}

@end
