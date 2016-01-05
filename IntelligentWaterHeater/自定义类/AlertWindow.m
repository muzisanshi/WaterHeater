//
//  AlertWindow.m
//  FindJob
//
//  Created by rimi on 14-12-8.
//  Copyright (c) 2014年 pengjin. All rights reserved.
//

#import "AlertWindow.h"
@interface AlertWindow()
@property (nonatomic ,retain) UILabel * titleLabel;
@end
@implementation AlertWindow

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = ({
            UILabel * label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            label.frame = CGRectMake( (mScreen.width-200)/2, (mScreen.height-64 - 100)/2, 200, 100);
            label.text = title;
            label.textAlignment = NSTextAlignmentCenter;
            label.layer.cornerRadius = 10;
            label.layer.masksToBounds = YES;
            label.numberOfLines = 0;
            label.font = [UIFont systemFontOfSize:16];
            label.textColor = [UIColor whiteColor];
            [self addSubview:label];
            label;
        });
    }
    self.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame action:(SEL)action {
//    self = [super initWithFrame:frame];
//    if (self) {
//        NSArray * arra = @[@"身高：",@"体重："];
//        for (int i = 0; i < 2; i ++) {
//            UIView * alertView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, frame.origin.x-20, i * frame.origin.y/3 + frame.origin.y/3 - 5)];
//            [self addSubview:alertView];
//            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, alertView.frame.origin.x/2, alertView.frame.origin.y)];
//            label.text = arra[i];
//            label.font = FONT(18);
//            [alertView addSubview:label];
//            UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetWidth(label.bounds), 0, CGRectGetWidth(alertView.bounds)- CGRectGetWidth(label.bounds), alertView.frame.origin.y/3)];
//            [alertView addSubview:textField];
//    
//        }
//        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.origin.x - 20, frame.origin.y/3)];
//        [button setTitle:@"确定" forState:UIControlStateNormal];
//        [button addTarget:nil action:action forControlEvents:UIControlEventTouchUpInside];
//        button.titleLabel.font = FONT(18);
//        [self addSubview:button];
//    }
//    return self;
//}


+ (void)showWithMessage:(NSString *)message canceDelay:(NSTimeInterval)delay
{
    AlertWindow * alertView = [[AlertWindow alloc] initWithFrame:CGRectMake(0, 64, mScreen.width, mScreen.height-64) title:message];
    [alertView setBackgroundColor:[UIColor clearColor]];
    UIWindow * keyWindow = [[[UIApplication sharedApplication] delegate] window];
    [keyWindow addSubview:alertView];
    [alertView performSelector:@selector(cancel) withObject:nil afterDelay:delay];
}

//+ (void)alerViewWihtHeightAndWeight:(SEL)action{
//    AlertWindow * alertView = [[AlertWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds] action:action];
//    [alertView setBackgroundColor:[UIColor colorWithWhite:0.2 alpha:0.4]];
//    UIWindow * keyWindow = [[[UIApplication sharedApplication] delegate] window];
//    [keyWindow addSubview:alertView];
//}

- (void)cancel
{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
