//
//  SearchDeviceView.m
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/7/30.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import "SearchDeviceView.h"

@implementation SearchDeviceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIButton * btn2 = [[UIButton alloc]initWithFrame:CGRectMake(50, frame.size.height / 2 - 30, mScreen.width - 100, 50)];
        btn2.layer.cornerRadius = 3;
        [btn2 setTitle:@"我要配置gokit" forState:(UIControlStateNormal)];
        [btn2 setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
        btn2.backgroundColor = kRGBADefault;
        [btn2 addTarget:self action:@selector(btn2) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:btn2];
        
        UIButton * btn3 = [[UIButton alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(btn2.frame)+20, mScreen.width - 100, 50)];
        btn3.layer.cornerRadius = 3;
        [btn3 setTitle:@"本地配置" forState:(UIControlStateNormal)];
        [btn3 setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
        btn3.backgroundColor = kRGBADefault;
        [btn3 addTarget:self action:@selector(btn3) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:btn3];
        
        UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(50, CGRectGetMinY(btn2.frame)-70, mScreen.width - 100, 50)];
        btn1.layer.cornerRadius = 3;
        [btn1 setTitle:@"二维码扫描添加虚拟设备" forState:(UIControlStateNormal)];
        [btn1 setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
        btn1.backgroundColor = kRGBADefault;
        [btn1 addTarget:self action:@selector(btn1) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:btn1];

    }
    return self;
}

- (void)btn2
{
    if (self.configurationGokitBlock) {
        self.configurationGokitBlock();
    }
}

- (void)btn1
{
    if (self.QRCodeBlock) {
        self.QRCodeBlock();
    }
}

- (void)btn3
{
    if (self.localConfigurationBlock) {
        self.localConfigurationBlock();
    }
}
@end
