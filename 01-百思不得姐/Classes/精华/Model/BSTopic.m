//
//  BSTopic.m
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/24.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "BSTopic.h"

@implementation BSTopic

- (NSString *)created_at {
    
    //日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期格式
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //发帖时间
    NSDate *create = [fmt dateFromString:_created_at];
    
    if (create.isThisYear) { //今年
        if (create.isToday) { //今天
            NSDateComponents * cmps = [[NSDate date] deltaFrom:create];
            if (cmps.hour >= 1) { //时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { //1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { //时间差距 < 1分钟
                return @"刚刚";
            }
        } else if (create.isYesterday) { //昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { //其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { //非今年
        return _created_at;
    }
    
}

@end
