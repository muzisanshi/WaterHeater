//
//  LeftChooseActionBtn.m
//  Sneez
//
//  Created by mac on 15/5/21.
//  Copyright (c) 2015年 dll. All rights reserved.
//

#import "LeftChooseActionBtn.h"

@implementation LeftChooseActionBtn

- (instancetype)initWithFrame:(CGRect)frame nomalImage:(NSString *)normalImage higlhtImage:(NSString *)higlhtImage
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self setImageEdgeInsets:(UIEdgeInsetsMake(0, -5, 0, 5))];
        [self setImage:[UIImage changeImageSizeImageName:normalImage width:35 height:35] forState:(UIControlStateNormal)];
        if (higlhtImage != nil) {
        [self setImage:[UIImage changeImageSizeImageName:higlhtImage width:35 height:35] forState:(UIControlStateSelected)];
        }
        [self addTarget:self action:@selector(prcossAction) forControlEvents:(UIControlEventTouchUpInside)];

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame name:(NSString *)name
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitle:name forState:(UIControlStateNormal)];
        [self setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
        [self addTarget:self action:@selector(prcossAction) forControlEvents:(UIControlEventTouchUpInside)];

    }
    return self;
}
- (void)prcossAction
{
    if (self.processAction) {
        self.processAction();
    }
}
@end
