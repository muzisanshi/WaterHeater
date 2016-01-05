//
//  leftBtn.m
//  WuZi
//
//  Created by SevenTC on 15/3/16.
//  Copyright (c) 2015年 chenfeng. All rights reserved.
//

#import "leftBtn.h"

@implementation leftBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage changeImageSizeImageName:@"return.png" width:25 height:25] forState:(UIControlStateNormal)];
//        [self setImage:[UIImage changeImageSizeImageName:leftHilghtImage width:20 height:20] forState:(UIControlStateHighlighted)];
        [self setImageEdgeInsets:(UIEdgeInsetsMake(0, -10, 0, 10))];
        [self addTarget:self action:@selector(prcossBack) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}

- (void)prcossBack
{
    if (    [UIApplication sharedApplication].networkActivityIndicatorVisible) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    }
    if (self.popAction) {
        self.popAction();
    }
    [[self navigationController] popViewControllerAnimated:YES];
}



//获取视图contr
-(UINavigationController *)navigationController
{
    for (UIView * next = [self superview] ; next; next = next.superview) {
        UIResponder * nextRes = [next nextResponder];
        if ([nextRes isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController*)nextRes;
        }
    }
    return nil;
}

@end
