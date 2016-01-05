//
//  RegisterView.m
//  IntelligentWaterHeater
//
//  Created by mac on 15/4/15.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import "RegisterView.h"
@interface RegisterView()<UITextFieldDelegate>
@end
@implementation RegisterView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray * placeholde = @[@"请输入电话号码",@"请输入密码",@"请确定密码",@"请输入短信验证码",@"请选择性别",@"请选择生日",@"请输入短信验证码"];
        NSArray * images = @[@"phone.png",@"key.png",@"key.png",@"petname.png",@"sex.png",@"birthday.png",@"yanzhengma.png"];
        for (int i = 0; i < 4; i ++) {
            UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake((0.1*mScreen.width-20)*0.5, 10+40*i, 20, 20)];
            image.image = [UIImage imageNamed:images[i]];
            [self addSubview:image];
            
            UITextField * textfiled = [[UITextField alloc]initWithFrame:CGRectMake(0.1*mScreen.width, 0+40*i, mScreen.width*0.8, 39)];
            textfiled.placeholder = placeholde[i];
            textfiled.tag = 10+i;
            textfiled.delegate = self;
            [self addSubview:textfiled];

                UIView * line = [[UIView alloc]initWithFrame:CGRectMake(mScreen.width*0.1, 40+40*i, mScreen.width*0.9, 1)];
                line.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.4];
                [self addSubview:line];
            if (i==3) {
                UIButton * Btn = [[UIButton alloc]initWithFrame:CGRectMake(mScreen.width*2/3, 0+40*i, mScreen.width/3, 40)];
                [Btn addTarget:self action:@selector(processBtn) forControlEvents:(UIControlEventTouchUpInside)];
                [Btn setBackgroundColor:[UIColor darkGrayColor]];
                [Btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [Btn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
                [Btn setTitle:@"获取短信验证码" forState:(UIControlStateNormal)];
                Btn.tag = 30+i;
                [self addSubview:Btn];
            }

        }
        
    }
    return self;
}

#pragma mark -- 获取验证码
- (void)processBtn
{
    if (self.getCodeBlock) {
        self.getCodeBlock();
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [((UITextField *)[self viewWithTag:textField.tag +1]) becomeFirstResponder];
    [textField resignFirstResponder];
    return YES;
}

@end
