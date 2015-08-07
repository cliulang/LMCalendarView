//
//  LMCalendarView.m
//  CalendarDemo
//
//  Created by zero on 15/6/17.
//  Copyright (c) 2015年 zero. All rights reserved.
//

#import "LMCalendarView.h"
#import "LMCollectionView.h"

@interface LMCalendarView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView* scrollView;
@property (nonatomic,strong) UIView* weekBarView;
@property (nonatomic,assign) NSInteger currentMonthDistance;
@property (nonatomic,strong) LMCollectionView* centerCollectionView;
@property (nonatomic,strong) LMCollectionView* topCollectionView;
@property (nonatomic,strong) LMCollectionView* bottomCollectionView;

@end

@implementation LMCalendarView



- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        
        // show the weekBar
        _weekBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), WeekBarHeight)];
        NSArray* array = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        for(int i =0; i<7; i++){
            UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(frame)/7.0*i, 0, CGRectGetWidth(frame)/7.0, 15)];
            label.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = array[i];
            [_weekBarView addSubview:label];
        }
        UIView* separtView = [[UIView alloc]initWithFrame:CGRectMake(0, 15, CGRectGetWidth(frame), 0.6)];
        separtView.backgroundColor = [UIColor darkGrayColor];
        [_weekBarView addSubview:separtView];
        [self addSubview:_weekBarView];
        
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_weekBarView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-WeekBarHeight)];
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        
        // CollectionView setup
        CGFloat collectionHeight;
        
        _topCollectionView = [[LMCollectionView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-WeekBarHeight)];
        _topCollectionView.dateComponents = [LMDateManager getOtherMonthComponentsWithCurrentDate:-1];
        [_scrollView addSubview:_topCollectionView];
        
        collectionHeight = CGRectGetHeight(_topCollectionView.frame);
        
        _centerCollectionView = [[LMCollectionView alloc]initWithFrame:CGRectMake(0, collectionHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-WeekBarHeight)];
        _centerCollectionView.dateComponents = [LMDateManager getDateComponentsWithDate:[NSDate date]];
        [_scrollView addSubview:_centerCollectionView];
        
        collectionHeight += CGRectGetHeight(_centerCollectionView.frame);
        
        _bottomCollectionView = [[LMCollectionView alloc]initWithFrame:CGRectMake(0, collectionHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-WeekBarHeight)];
        _bottomCollectionView.dateComponents = [LMDateManager getOtherMonthComponentsWithCurrentDate:1];
        [_scrollView addSubview:_bottomCollectionView];
        
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(frame), CGRectGetMaxY(_bottomCollectionView.frame));
        
        _scrollView.contentOffset = CGPointMake(0, CGRectGetHeight(_topCollectionView.frame));
        [self updateFrameWithCollectionFrame:_centerCollectionView.frame];
        
        _currentMonthDistance = 0;
    }
    return self;
}

- (void)updateToCurrentMonth{
    _topCollectionView.dateComponents = [LMDateManager getOtherMonthComponentsWithCurrentDate:-1];
    _centerCollectionView.dateComponents = [LMDateManager getDateComponentsWithDate:[NSDate date]];
    _bottomCollectionView.dateComponents = [LMDateManager getOtherMonthComponentsWithCurrentDate:1];
    [self changeView:_centerCollectionView Frame:CGRectGetHeight(_topCollectionView.frame)];
    [self changeView:_bottomCollectionView Frame:CGRectGetHeight(_topCollectionView.frame)+CGRectGetHeight(_centerCollectionView.frame)];
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetMaxY(_bottomCollectionView.frame));
    _scrollView.contentOffset = CGPointMake(0, CGRectGetHeight(_topCollectionView.frame));
    [self updateFrameWithCollectionFrame:_centerCollectionView.frame];
    _currentMonthDistance = 0;
}

- (void)updateFrameWithCollectionFrame:(CGRect)frame{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = _scrollView.frame;
        rect.size.height = CGRectGetHeight(frame);
        _scrollView.frame = rect;
        rect = self.frame;
        rect.size.height = WeekBarHeight + CGRectGetHeight(frame);
        self.frame = rect;
    }completion:^(BOOL finished) {
        if(finished){
            //交换tableview。
             [self changeTableView];
        }
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 当显示top时候
    if(scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y < CGRectGetHeight(_topCollectionView.frame)/2.0){
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            //调整位置，正好显示topCollectionView
            scrollView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            //因为每个月天数不一样。所以要调整scrollView的frame
            [self updateFrameWithCollectionFrame:_topCollectionView.frame];
        }];
        //当显示center时候
    }else if(scrollView.contentOffset.y > CGRectGetHeight(_topCollectionView.frame)/2.0 && scrollView.contentOffset.y < CGRectGetHeight(_topCollectionView.frame) + CGRectGetHeight(_centerCollectionView.frame)/2.0){
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            scrollView.contentOffset = CGPointMake(0, CGRectGetHeight(_topCollectionView.frame));
        } completion:^(BOOL finished) {
            [self updateFrameWithCollectionFrame:_centerCollectionView.frame];
        }];
        //当显示bottom时候
    }else if(scrollView.contentOffset.y > CGRectGetHeight(_topCollectionView.frame) + CGRectGetHeight(_centerCollectionView.frame)/2.0){
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            scrollView.contentOffset = CGPointMake(0, CGRectGetHeight(_topCollectionView.frame)+CGRectGetHeight(_centerCollectionView.frame));
        } completion:^(BOOL finished) {
            [self updateFrameWithCollectionFrame:_bottomCollectionView.frame];
        }];
    }
}

- (void)changeView:(UICollectionView*)view Frame:(CGFloat)frameY{
    CGRect rect = view.frame;
    rect.origin.y = frameY;
    view.frame = rect;
}

- (void)changeTableView{
    //始终保持centerCollectionView为滚动到的月份
    CGFloat height = _scrollView.contentOffset.y;
    if(height < CGRectGetHeight(_topCollectionView.frame)){
        //往上滚， 月份减少
        _currentMonthDistance -= 1;
        //center获取top的月份，bottom获取center的月份
        _centerCollectionView.dateComponents = _topCollectionView.dateComponents;
        _bottomCollectionView.dateComponents = [LMDateManager getOtherMonthComponentsWithCurrentDate: _currentMonthDistance+1];
        //移动到center的位置。
        [_scrollView setContentOffset:CGPointMake(0, CGRectGetHeight(_topCollectionView.frame) )animated:NO];
        //更换top的月份，由于月份改变，frame变化，scrollview的size也将变化，center和bottom的起始y也会变化
        NSInteger topMonth = _currentMonthDistance-1;
        _topCollectionView.dateComponents = [LMDateManager getOtherMonthComponentsWithCurrentDate:topMonth];
        CGFloat top = CGRectGetHeight(_topCollectionView.frame);
        CGFloat center = CGRectGetHeight(_centerCollectionView.frame);
        CGFloat bottom = CGRectGetHeight(_bottomCollectionView.frame);
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame), top+center+bottom);
        [self changeView:_centerCollectionView Frame:top];
        [self changeView:_bottomCollectionView Frame:top+center];
         [_scrollView setContentOffset:CGPointMake(0, top)animated:NO];
        
    }else if(height >= CGRectGetHeight(_topCollectionView.frame) && height < CGRectGetHeight(_topCollectionView.frame)+ CGRectGetHeight(_centerCollectionView.frame)){
        //没变。。。还是显示的当前的月份，啥都不做
    }else{
        //往下滚， 月份增加
        _currentMonthDistance += 1;
        //center获取bottom的月份，top获取center的月份
        _topCollectionView.dateComponents = [LMDateManager getOtherMonthComponentsWithCurrentDate: _currentMonthDistance-1];
        _centerCollectionView.dateComponents = _bottomCollectionView.dateComponents;
        //移动到center的位置。
        NSLog(@"%f",CGRectGetHeight(_topCollectionView.frame));
        [_scrollView setContentOffset:CGPointMake(0, CGRectGetHeight(_topCollectionView.frame))animated:NO];
        //更换bottom的月份，由于月份改变，frame变化，scrollview的size也将变化
        NSInteger bottomMonth = _currentMonthDistance+1;
        _bottomCollectionView.dateComponents = [LMDateManager getOtherMonthComponentsWithCurrentDate:bottomMonth];
        CGFloat top = CGRectGetHeight(_topCollectionView.frame);
        CGFloat center = CGRectGetHeight(_centerCollectionView.frame);
        CGFloat bottom = CGRectGetHeight(_bottomCollectionView.frame);
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame), top+center+bottom);
        [self changeView:_centerCollectionView Frame:top];
        [self changeView:_bottomCollectionView Frame:_scrollView.contentSize.height-bottom];
        [_scrollView setContentOffset:CGPointMake(0, top)animated:NO];
    }
}

@end
