//
//  LMCollectionView.m
//  CalendarDemo
//
//  Created by zero on 15/6/18.
//  Copyright (c) 2015年 zero. All rights reserved.
//

#import "LMCollectionView.h"
#import "LMDateManager.h"
#import "LMCalendarCollectionViewCell.h"

@interface LMCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,assign) NSInteger daysOfmonth;
@property (nonatomic,assign) NSInteger weeksOfmonth;
@property (nonatomic,strong) NSIndexPath* selectIndexPath;
@property (nonatomic,assign) BOOL isCurrentMonth; // 只有当当前月显示的时候，才会在当日标记红色背景

@end

@implementation LMCollectionView

- (id)initWithFrame:(CGRect)frame{
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(frame)/7.0, CellHeight);
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.dataSource = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[LMCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"LMCalendarCollectionViewCell"];
        [self registerClass:[LMCalendarCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LMCalendarCollectionHeaderView"];
    }
    
    return self;
}

- (void)setCollectionDate:(NSDate *)collectionDate{
    if(_collectionDate != collectionDate){
        NSCalendar* calendar = [NSCalendar currentCalendar];
        
        NSString* str = [LMDateManager toStringWithDate:collectionDate Formatter:@"yyyy-MM-dd hh:mm:ss"];
        NSDate* date =  [LMDateManager toDateWithString:str Formatter:@"yyyy-MM-dd hh:mm:ss"];
        _collectionDate = date;
        _dateComponents = [LMDateManager getDateComponentsWithDate:collectionDate];
        
    }
}

- (void)setDateComponents:(NSDateComponents *)dateComponents{
    if(_dateComponents != dateComponents){
        _dateComponents = dateComponents;
        _daysOfmonth = [LMDateManager getDaysInMonth:_dateComponents.month year:_dateComponents.year];
        _weeksOfmonth = (_daysOfmonth+_dateComponents.weekday-1)/7;
        if((_daysOfmonth+_dateComponents.weekday-1)%7 != 0){
            _weeksOfmonth ++ ;
        }
        CGRect rect = self.frame;
        rect.size.height = CellHeight * _weeksOfmonth + HeaderViewHeight;
        self.frame = rect;
        if(_dateComponents.month == [LMDateManager getDateComponentsWithDate:[NSDate date]].month){
            _isCurrentMonth = YES;
        }else{
            _isCurrentMonth  = NO;
        }
        [self reloadData];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _weeksOfmonth * 7 ;
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if(kind == UICollectionElementKindSectionHeader){
        LMCalendarCollectionHeaderView* headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LMCalendarCollectionHeaderView" forIndexPath:indexPath];
        headerView.titleLabel.text =  [NSString stringWithFormat:@"%li  %@",_dateComponents.year,[LMDateManager getMonths][_dateComponents.month-1]];
        return headerView;
    }
    return nil;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LMCalendarCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LMCalendarCollectionViewCell" forIndexPath:indexPath];
    if((indexPath.row < _dateComponents.weekday-1) || (indexPath.row > _dateComponents.weekday - 1+ _daysOfmonth -1)){
        cell.hidden = YES;
    }else{
        cell.hidden = NO;
        NSInteger currentDay = indexPath.row - _dateComponents.weekday + 2;
        cell.dateLabel.text = [NSString stringWithFormat:@"%li", currentDay];
        if(_isCurrentMonth && _dateComponents.day == currentDay){
            [cell setCurrentDay:YES];
        }else{
            [cell setCurrentDay:NO];
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"select: %li",indexPath.row);
    if(_selectIndexPath != nil){
        LMCalendarCollectionViewCell* cell = (LMCalendarCollectionViewCell*)[collectionView cellForItemAtIndexPath:_selectIndexPath];
        [cell setSelectedCurrentCell:NO];
    }
    _selectIndexPath = indexPath;
    LMCalendarCollectionViewCell* cell = (LMCalendarCollectionViewCell*)[collectionView cellForItemAtIndexPath:_selectIndexPath];
    [cell setSelectedCurrentCell:YES];
    
}

#pragma mark

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CGRectGetWidth(collectionView.frame)/7.0, CellHeight);
}

// 竖直方向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

// 水平方向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//headerView Size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(CGRectGetWidth(self.frame), HeaderViewHeight);
}


@end
