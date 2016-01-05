//
//  SetTimeAndTemView.m
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/11/4.
//  Copyright © 2015年 dailinli. All rights reserved.
//

#import "SetTimeAndTemView.h"
@interface SetTimeAndTemView()
{
    UIDatePicker * datePicker;
}
@end
@implementation SetTimeAndTemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.4];
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(50, 64, frame.size.width -100, 439)];
        view.center = self.center;
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];

        
        UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(2, 2, view.frame.size.width -4, view.frame.size.height - 4)];
        view1.layer.borderWidth = 0.5;
        view1.layer.borderColor = [UIColor grayColor].CGColor;
        [view addSubview:view1];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, view1.frame.size.width-30, 40)];
        titleLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"title_backg.png"]];
        titleLabel.text = @"设置预约时间和温度";
        titleLabel.textColor = [UIColor colorWithRed:0.055f green:0.569f blue:0.612f alpha:1.00f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [view1 addSubview:titleLabel];
        
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titleLabel.frame)+30, view1.frame.size.width - 30, 150)];
        [datePicker setDatePickerMode:UIDatePickerModeTime];
        [view1 addSubview:datePicker];
        
        _temLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(datePicker.frame)+30, view1.frame.size.width-30, 40)];
        _temLabel.textColor = [UIColor colorWithRed:0.055f green:0.569f blue:0.612f alpha:1.00f];
        _temLabel.text = @"20℃";
        _temLabel.textAlignment = NSTextAlignmentCenter;
        [view1 addSubview:_temLabel];
        
        UILabel * minLable = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_temLabel.frame)+15, 30, 40)];
        minLable.textColor = [UIColor colorWithRed:0.055f green:0.569f blue:0.612f alpha:1.00f];
        minLable.text = @"20°";
        minLable.textAlignment = NSTextAlignmentCenter;
        [view1 addSubview:minLable];

        
        UILabel * maxLable = [[UILabel alloc] initWithFrame:CGRectMake(view1.frame.size.width - 15 -30, CGRectGetMaxY(_temLabel.frame)+15, 30, 40)];
        maxLable.textColor = [UIColor colorWithRed:0.055f green:0.569f blue:0.612f alpha:1.00f];
        maxLable.text = @"80°";
        maxLable.textAlignment = NSTextAlignmentCenter;
        [view1 addSubview:maxLable];
        
        UISlider * slider = [[UISlider alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(_temLabel.frame)+20, view1.frame.size.width - 100, 30)];
        slider.tintColor = [UIColor colorWithRed:0.055f green:0.569f blue:0.612f alpha:1.00f];
        slider.minimumValue = 20.0;
        slider.maximumValue = 80.0;
        [slider addTarget:self action:@selector(sliderAction:) forControlEvents:(UIControlEventValueChanged)];
        [view1 addSubview:slider];
        
        for (int i = 0; i <2; i ++) {
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(15+ (view1.frame.size.width - 30+10)/2*i,  CGRectGetMaxY(slider.frame)+25, (view1.frame.size.width - 30)/2-5 , 40)];
            button.backgroundColor = [UIColor grayColor];
            [button addTarget:self action:@selector(sureOrCancelAction:) forControlEvents:(UIControlEventTouchUpInside)];
            button.tag = 888+i;
            if (i == 0) {
                [button setTitle:@"确定" forState:(UIControlStateNormal)];
                
            }else{
                [button setTitle:@"取消" forState:(UIControlStateNormal)];
            }
            [view1 addSubview:button];
        }
        

    }
    return self;
}
-(void)sureOrCancelAction:(UIButton *)sender
{
    if (sender.tag == 888) {
        if (self.sureBlock) {
            self.sureBlock([NSString stringWithFormat:@"%@",[[datePicker date] dateByAddingTimeInterval:3600*8]],[datePicker date]);
        }
    }
    [self removeFromSuperview];
}

- (void)sliderAction:(UISlider *)slider
{
    _temLabel.text = [NSString stringWithFormat:@"%.0f℃",slider.value];
}
@end
