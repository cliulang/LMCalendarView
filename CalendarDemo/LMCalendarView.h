//
//  LMCalendarView.h
//  CalendarDemo
//
//  Created by zero on 15/6/17.
//  Copyright (c) 2015年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMDateManager.h"

@interface LMCalendarView : UIView


// default is YES, if YES, show WeekBar on Carlendar
@property (nonatomic,assign) BOOL showWeekBar;

// can scroll to current month;
- (void)updateToCurrentMonth;

@end
