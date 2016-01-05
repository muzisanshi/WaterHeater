//
//  UIImage+ImageSize.h
//  WuZi
//
//  Created by SevenTC on 15/3/9.
//  Copyright (c) 2015年 chenfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageSize)
+ (UIImage *)changeImageSizeImageName:(NSString *)imageName width:(CGFloat)width height:(CGFloat)height;
+ (UIImage *)changeImageSizeImage:(UIImage *)image width:(CGFloat)width height:(CGFloat)height;

@end
