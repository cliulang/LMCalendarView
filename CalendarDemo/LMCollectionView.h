//
//  LMCollectionView.h
//  CalendarDemo
//
//  Created by zero on 15/6/18.
//  Copyright (c) 2015年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WeekBarHeight 20
#define CellHeight 55
#define HeaderViewHeight 25

@interface LMCollectionView : UICollectionView
@property (nonatomic,strong)  NSDate* collectionDate;
@property (nonatomic,strong) NSDateComponents* dateComponents;

@end
