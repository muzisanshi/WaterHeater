//
//  NSString+TextSize.h
//  FindAJob
//
//  Created by wangzheng on 14-2-24.
//  Copyright (c) 2014年 wangzheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TextSize)
/**
 * 返回文本高度
 */
+ (CGFloat)getTextHeightWithFont:(UIFont *)font forWidth:(CGFloat)width text:(NSString *)text;
@end
