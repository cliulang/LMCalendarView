//
//  LMCalendarCollectionViewCell.h
//  CalendarDemo
//
//  Created by zero on 15/6/17.
//  Copyright (c) 2015年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMCalendarCollectionViewCell : UICollectionViewCell


@property (nonatomic,strong) UIView* topLineView;

//the label showing the cel


@property (nonatomic,strong) UILabel* dateLabel;

// the color of select circle background
@property (nonatomic,strong) UIColor* selectCircleColor;

// change the background of the current day to  red
@property (nonatomic,assign) BOOL currentDay;


//- (void)setCurrentDay:(BOOL)isCurrent;

//change the background of cell with selected
- (void)setSelectedCurrentCell:(BOOL)selected;

@end


@interface LMCalendarCollectionHeaderView : UICollectionReusableView

@property (nonatomic,strong) UILabel* titleLabel;

@end
