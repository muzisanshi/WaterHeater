//
//  HomePageBottomView.m
//  IntelligentWaterHeater
//
//  Created by mac on 15/4/11.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import "HomePageBottomView.h"

@implementation HomePageBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray * title = @[@"帮助",@"关于"];
        for ( int i = 0; i <2; i ++) {
            self.backgroundColor = [UIColor blackColor];
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width/2*i, 0, frame.size.width/2, frame.size.height)];
            [btn setTitle:title[i] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
//            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            btn.tag = 30+i;
            [btn addTarget:self action:@selector(btn:) forControlEvents:(UIControlEventTouchUpInside)];
            [self addSubview:btn];
        }
    }
    return self;
}

- (void)btn:(UIButton *)sender
{
    if (sender.tag == 30 && self.helpBlock ) {
        self.helpBlock();
    }else if (sender.tag == 31 && self.aboutBlock){
        self.aboutBlock();
    }
}
@end
