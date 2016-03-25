//
//  NSDate+BSExtension.m
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/25.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "NSDate+BSExtension.h"

@implementation NSDate (BSExtension)

- (NSDateComponents *)deltaFrom:(NSDate *)from {
    
    //日历
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    //比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calender components:unit fromDate:from toDate:self options:0];
    
}

- (BOOL)isThisYear{
    //日历
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calender component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calender component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}

//- (BOOL)isToday{
//    //日历
//    NSCalendar *calender = [NSCalendar currentCalendar];
//    
//    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
//    
//    NSDateComponents *nowCmps = [calender components:unit fromDate:[NSDate date]];
//    NSDateComponents *selfCmps = [calender components:unit fromDate:self];
//    
//    return nowCmps.year == selfCmps.year && nowCmps.month == selfCmps.month && nowCmps.day == selfCmps.day;
//}

- (BOOL)isToday {
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    
    return [nowString isEqualToString:selfString];
}

- (BOOL)isYesterday {
    
    //日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    //日历
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calender components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

@end
