//
//  NSString+TimeTurnTimeStamp.m
//  WuZi
//
//  Created by mac on 15/4/9.
//  Copyright (c) 2015年 chenfeng. All rights reserved.
//

#import "NSString+TimeTurnTimeStamp.h"

@implementation NSString (TimeTurnTimeStamp)
+(NSString *)timeToTurnTimeStamp:(NSDate *)date
{
    //计算时间，预约时间要大于当前时间一小时
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss +0800"];//修改时区为东8区
    NSString *dateString = [dateFormatter stringFromDate:date];
    //标准时间转化为时间戳,当前时间
    NSDate *date2 = [dateFormatter dateFromString:dateString];
    return  [NSString stringWithFormat:@"%ld", (long)[date2 timeIntervalSince1970]];
}
@end
