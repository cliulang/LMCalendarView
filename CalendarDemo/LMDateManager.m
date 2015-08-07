//
//  LMDateManager.m
//  CalendarDemo
//
//  Created by zero on 15/6/16.
//  Copyright (c) 2015年 zero. All rights reserved.
//

#import "LMDateManager.h"

@implementation LMDateManager

+ (int)getDaysInMonth:(int)month year:(int)year
{
    int daysInFeb = 28;
    if (year%4 == 0) {
        daysInFeb = 29;
    }
    int daysInMonth [12] = {31,daysInFeb,31,30,31,30,31,31,30,31,30,31};
    return daysInMonth[month-1];
}


+ (NSDateComponents*)getDateComponentsWithDate:(NSDate*)date{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:(NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitWeekOfMonth | NSCalendarUnitEra) fromDate:[NSDate date]];
    return components;
}


+ (NSDateComponents*)getOtherMonthComponentsWithCurrentDate:(NSInteger)month{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* new = [[NSDateComponents alloc]init];
    new.month = month;
    NSDate *date =  [calendar dateByAddingComponents:new toDate:[NSDate date] options:NSCalendarMatchNextTime];
    NSDateComponents* com =  [calendar components:(NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitWeekOfMonth | NSCalendarUnitEra) fromDate:date];
    NSLog(@"\n第%li月",com.month);
    return com;
}


+ (NSArray*)getMonths{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    return calendar.monthSymbols;
}


+ (BOOL)earlierThanDate:(NSDate*)_date WithYear:(NSInteger)_year Month:(NSInteger)_month Day:(NSInteger)_day{
    NSDateComponents* components =  [self getDateComponentsWithDate:_date];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    if(_year < year){
        return YES;
    }else if(_year == year){
        if(_month < month){
            return YES;
        }else if(_month == month && _day < day){
            return YES;
        }
    }
    return NO;
}
+ (BOOL)isEqualToDate:(NSDate*)_date WithYear:(NSInteger)_year Month:(NSInteger)_month Day:(NSInteger)_day{
    NSDateComponents* components =  [self getDateComponentsWithDate:_date];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    if(year == _year && month == _month && day == _day){
        return YES;
    }
    return NO;
}
+ (BOOL)laterThanDate:(NSDate*)_date WithYear:(NSInteger)_year Month:(NSInteger)_month Day:(NSInteger)_day{
    NSDateComponents* components =  [self getDateComponentsWithDate:_date];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    if(_year > year){
        return YES;
    }else if(_year == year){
        if(_month > year){
            return YES;
        }else if(_month == month && _day > day){
            return YES;
        }
    }
    return NO;
}
+ (BOOL)laterThanDate:(NSDate*)_date WithHour:(NSInteger)_hour Minute:(NSInteger)_minute{
    NSDateComponents* components =  [self getDateComponentsWithDate:_date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    if(_hour > hour){
        return YES;
    }else if(_hour == hour && _minute > minute){
        return YES;
    }
    return NO;
}
+ (BOOL)isEqualToDate:(NSDate *)_date WithHour:(NSInteger)_hour Minute:(NSInteger)_minute{
    NSDateComponents* components = [self getDateComponentsWithDate:_date];
    if(components.hour == _hour && components.minute == _minute){
        return YES;
    }
    return NO;
}
+ (BOOL)earlierThanDate:(NSDate*)_date WithHour:(NSInteger)_hour Minute:(NSInteger)_minute{
    NSDateComponents* components = [self getDateComponentsWithDate:_date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    if(_hour < hour){
        return YES;
    }else if(_hour == hour && _minute < minute){
        return YES;
    }
    return NO;
}

+ (NSDate*)getDateWithHour:(NSInteger)_hour Minutes:(NSInteger)_minutes{
    //    _hour += 8;
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *myComponents = [gregorian components:(NSDayCalendarUnit | NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSMinuteCalendarUnit | NSHourCalendarUnit) fromDate:[NSDate date]];
    myComponents.calendar = gregorian;
    myComponents.hour = _hour;
    myComponents.minute = _minutes;
    NSDate* date = [gregorian dateFromComponents:myComponents];
    return date;
}
+ (NSString*)toStringWithDate:(NSDate*)date Formatter:(NSString*)formatter{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:formatter];
    NSString* string = [dateFormatter stringFromDate:date];
    return string;
}

+ (NSDate*)toDateWithString:(NSString*)time Formatter:(NSString*)formatter{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:formatter];
    //    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    //    [dateFormatter setTimeZone:timeZone];
    NSDate* date = [dateFormatter dateFromString:time];
    return date;
}

@end

