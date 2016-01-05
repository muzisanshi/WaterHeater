//
//  UIImage+ImageSize.m
//  WuZi
//
//  Created by SevenTC on 15/3/9.
//  Copyright (c) 2015年 chenfeng. All rights reserved.
//

#import "UIImage+ImageSize.h"

@implementation UIImage (ImageSize)
+ (UIImage *)changeImageSizeImageName:(NSString *)imageName width:(CGFloat)width height:(CGFloat)height
{
    UIImage * icon = [UIImage imageNamed:imageName];
    
    
    if([[UIScreen mainScreen] scale] == 2.0){
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, 2.0);
    }else if ([[UIScreen mainScreen] scale] == 3.0){
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, 2.0);
    }
    // 绘制改变大小的图片
    [icon drawInRect:CGRectMake(0, 0, width, height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;

}

+ (UIImage *)changeImageSizeImage:(UIImage *)image width:(CGFloat)width height:(CGFloat)height
{
    UIImage * icon = image;
    
    
    if([[UIScreen mainScreen] scale] == 2.0){
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, 2.0);
    }else if ([[UIScreen mainScreen] scale] == 3.0){
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, 2.0);
    }
    // 绘制改变大小的图片
    [icon drawInRect:CGRectMake(0, 0, width, height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
    
}


@end
