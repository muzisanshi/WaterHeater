//
//  NSString+TimeStampStandardTime.h
//  WuZi
//
//  Created by SevenTC on 15/3/24.
//  Copyright (c) 2015年 chenfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TimeStampStandardTime)
/**
 * 时间戳转时间 XXXX-XX-XX
 */
+ (NSString *)TimeStampStandardTimeWithTimeStamp:(NSString *)timeStamp;

@end
