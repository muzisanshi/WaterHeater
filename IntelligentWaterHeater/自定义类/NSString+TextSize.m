//
//  NSString+TextSize.m
//  FindAJob
//
//  Created by wangzheng on 14-2-24.
//  Copyright (c) 2014年 wangzheng. All rights reserved.
//

#import "NSString+TextSize.h"

@implementation NSString (TextSize)

                
+ (CGFloat)getTextHeightWithFont:(UIFont *)font forWidth:(CGFloat)width text:(NSString *)text
{
    CGRect labeRect = [text boundingRectWithSize:CGSizeMake(width, 3000) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    return labeRect.size.height;
}

@end
