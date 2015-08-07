//
//  LMDateManager.h
//  CalendarDemo
//
//  Created by zero on 15/6/16.
//  Copyright (c) 2015年 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMDateManager : NSObject


// return the count of day in a certain month ,a certain year
+ (int)getDaysInMonth:(int)month year:(int)year;

// get the dateComponents from the date, you can get some info from dateComponents
+ (NSDateComponents*)getDateComponentsWithDate:(NSDate*)date;

// return the array of month name in a year
+ (NSArray*)getMonths;

// according to the current date , +/- month , return a new dateComponents with new month
+ (NSDateComponents*)getOtherMonthComponentsWithCurrentDate:(NSInteger)month;

//Time
+ (BOOL)isEqualToDate:(NSDate *)_date WithHour:(NSInteger)_hour Minute:(NSInteger)_minute;
+ (BOOL)earlierThanDate:(NSDate*)_date WithHour:(NSInteger)_hour Minute:(NSInteger)_minute;
+ (BOOL)laterThanDate:(NSDate*)_date WithHour:(NSInteger)_hour Minute:(NSInteger)_minute;

//Year
+ (BOOL)isEqualToDate:(NSDate*)_date WithYear:(NSInteger)_year Month:(NSInteger)_month Day:(NSInteger)_day;
+ (BOOL)earlierThanDate:(NSDate*)_date WithYear:(NSInteger)_year Month:(NSInteger)_month Day:(NSInteger)_day;
+ (BOOL)laterThanDate:(NSDate*)_date WithYear:(NSInteger)_year Month:(NSInteger)_month Day:(NSInteger)_day;

+ (NSDate*)getDateWithHour:(NSInteger)_hour Minutes:(NSInteger)_minute;
//yyyy-MM-dd hh:mm:ss
+ (NSString*)toStringWithDate:(NSDate*)date Formatter:(NSString*)formatter;
+ (NSDate*)toDateWithString:(NSString*)time Formatter:(NSString*)formatter;


@end
