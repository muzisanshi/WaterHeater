//
//  SetWifiView.m
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/8/8.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import "SetWifiView.h"
@interface SetWifiView()<UITextFieldDelegate>
@end
@implementation SetWifiView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i = 0; i < 3; i ++) {
            UITextField *text = [[UITextField alloc]initWithFrame:CGRectMake(30, 30+ 70*i, mScreen.width - 60, 40)];
            text.tag = 30+i;
            text.delegate = self;
            if (i == 0) {
                text.enabled = NO;
                text.text = @"请保持Wi-Fi连接";
                text.textAlignment = NSTextAlignmentCenter;
            }else if (i == 1){
                [text setBorderStyle:UITextBorderStyleBezel];
                text.enabled = NO;
            }else if (i == 2){
                text.placeholder = @"Wi-Fi密码";
                text.secureTextEntry = YES;
                UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(mScreen.width/3, CGRectGetMaxY(text.frame)+30, mScreen.width/3, 40)];
                btn.backgroundColor = kRGBADefault;
                [btn setTitle:@"配置设备" forState:(UIControlStateNormal)];
                [btn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
                [self addSubview:btn];
                
                [btn addTarget:self action:@selector(setWiFi) forControlEvents:(UIControlEventTouchUpInside)];
                [text setBorderStyle:UITextBorderStyleBezel];

            }
            
            
            [self addSubview:text];
        }
    }
    return self;
}

- (void)setWiFi
{
    [((UITextField *)[self viewWithTag:32]) resignFirstResponder];
    if (((UITextField *)[self viewWithTag:31]).text.length == 0 || ((UITextField *)[self viewWithTag:32]).text.length == 0) {
        [AlertWindow showWithMessage:@"请检查输入项" canceDelay:1];
        return;
    }
    if ( self.setWiFiBlock) {
        self.setWiFiBlock(((UITextField *)[self viewWithTag:31]).text,((UITextField *)[self viewWithTag:32]).text);
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}
@end
