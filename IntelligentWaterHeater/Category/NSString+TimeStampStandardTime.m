//
//  NSString+TimeStampStandardTime.m
//  WuZi
//
//  Created by SevenTC on 15/3/24.
//  Copyright (c) 2015年 chenfeng. All rights reserved.
//

#import "NSString+TimeStampStandardTime.h"

@implementation NSString (TimeStampStandardTime)
+ (NSString *)TimeStampStandardTimeWithTimeStamp:(NSString *)timeStamp
{
    
    return [NSString stringWithFormat:@"%@", [NSDate dateWithTimeInterval:8*60*60 sinceDate:[NSDate dateWithTimeIntervalSince1970:[timeStamp intValue]]]] ;
}
@end
