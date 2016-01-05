//
//  ChangePassController.m
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/8/8.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import "ChangePassController.h"

@interface ChangePassController ()<UITextFieldDelegate,XPGWifiSDKDelegate>

@end

@implementation ChangePassController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改密码";
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray * placeHold = @[@"旧密码",@"新密码"];
    
    
    for (int i = 0; i < 3; i ++) {
        if (i < 2) {
            UITextField * text = [[UITextField alloc]initWithFrame:CGRectMake(30, 40+70*i, mScreen.width - 60, 40)];
            text.delegate = self;
            [text setBorderStyle:UITextBorderStyleBezel];
            text.placeholder = placeHold[i];
            [self.view addSubview:text];
            text.tag = 20+i;
            if (i == 1) {
                text.secureTextEntry = YES;
            }
        }else{
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(mScreen.width/3, 40+70*i, mScreen.width/3, 40)];
            btn.backgroundColor = kRGBA(27, 112, 230, 1);
            [btn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
            [btn setTitle:@"确定" forState:(UIControlStateNormal)];
            [self.view addSubview:btn];
            [btn addTarget:self action:@selector(changePass) forControlEvents:(UIControlEventTouchUpInside)];
        }
        
    }
    [XPGWifiSDK sharedInstance].delegate = self;
    
}

- (void)changePass
{
    [((UITextField *)[self.view viewWithTag:20]) resignFirstResponder];
    [((UITextField *)[self.view viewWithTag:21]) resignFirstResponder];
    [[XPGWifiSDK sharedInstance]  changeUserPassword:[Userinfo currentUser].token oldPassword:((UITextField *)[self.view viewWithTag:20]).text newPassword:((UITextField *)[self.view viewWithTag:21]).text];
}
- (void)XPGWifiSDK:(XPGWifiSDK *)wifiSDK didChangeUserPassword:(NSNumber *)error errorMessage:(NSString *)errorMessage;
{
    if ([error integerValue] == 0) {
        
        [AlertWindow showWithMessage:@"修改成功, 请重新登录" canceDelay:1];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kUserInfo"];

        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
        [AlertWindow showWithMessage:errorMessage canceDelay:1];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
