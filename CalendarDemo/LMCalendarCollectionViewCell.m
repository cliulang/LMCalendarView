//
//  LMCalendarCollectionViewCell.m
//  CalendarDemo
//
//  Created by zero on 15/6/17.
//  Copyright (c) 2015年 zero. All rights reserved.
//

#import "LMCalendarCollectionViewCell.h"

@implementation LMCalendarCollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        
        _topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), 0.6)];
        _topLineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_topLineView];
        _selectCircleColor = [UIColor blueColor];
        CGFloat distance = 5;
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(distance, distance, CGRectGetWidth(frame)-distance*2, CGRectGetWidth(frame)-distance*2)];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.layer.masksToBounds = YES;
        _dateLabel.layer.cornerRadius = (CGRectGetWidth(frame)-distance*2)/2.0;
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_dateLabel];
    }
    return self;
}

- (void)setSelectedCurrentCell:(BOOL)selected{
    if(_currentDay){
        return;
    }else{
        if(selected){
            [_dateLabel setBackgroundColor:_selectCircleColor];
            [_dateLabel setTextColor:[UIColor whiteColor]];
        }else{
            [_dateLabel setBackgroundColor:[UIColor clearColor]];
            [_dateLabel setTextColor:[UIColor blackColor]];
        }
    }
    
}

- (void)setCurrentDay:(BOOL)currentDay{
    if(_currentDay != currentDay){
        _currentDay = currentDay;
    }
    if (currentDay) {
        [_dateLabel setBackgroundColor:[UIColor redColor]];
        [_dateLabel setTextColor:[UIColor whiteColor]];
    }else{
        [_dateLabel setBackgroundColor:[UIColor clearColor]];
        [_dateLabel setTextColor:[UIColor blackColor]];
    }
}

@end


@interface LMCalendarCollectionHeaderView ()

@end

@implementation LMCalendarCollectionHeaderView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        _titleLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_titleLabel];
    }
    return self;
}

@end

