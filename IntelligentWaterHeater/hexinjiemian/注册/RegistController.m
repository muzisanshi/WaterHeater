//
//  RegistController.m
//  IntelligentWaterHeater
//
//  Created by mac on 15/4/15.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import "RegistController.h"
#import "RegisterView.h"
@interface RegistController ()<XPGWifiSDKDelegate>
@property (nonatomic, strong) RegisterView * registView;
@end

@implementation RegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成注册" style:(UIBarButtonItemStylePlain) target:self action:@selector(DoneRgist)];
    [self initUserInterface];
    [XPGWifiSDK sharedInstance].delegate = self;
    
}

- (void)initUserInterface
{
    _registView = [[RegisterView alloc]initWithFrame:CGRectMake(0, 64, mScreen.width, 180)];
    [self.view addSubview:_registView];
    __weak RegistController * registC = self;
    _registView.getCodeBlock = ^{
        [registC getAuthCode];
    };
}

#pragma mark -- 获取短信验证码
- (void)getAuthCode
{
    [[XPGWifiSDK sharedInstance] requestSendVerifyCode:((UITextField *)[_registView viewWithTag:10]).text];
}
- (void)XPGWifiSDK:(XPGWifiSDK *)wifiSDK didRequestSendVerifyCode:(NSNumber *)error errorMessage:(NSString *)errorMessage {
    if (error == 0) {
        // the phone code has been sent successfully
        [AlertWindow showWithMessage:@"验证码发送成功" canceDelay:1];
    }
}

#pragma mark -- 完成注册
- (void)DoneRgist
{
    [[XPGWifiSDK sharedInstance] registerUserByPhoneAndCode:((UITextField *)[_registView viewWithTag:10]).text password:((UITextField *)[_registView viewWithTag:11]).text code:((UITextField *)[_registView viewWithTag:13]).text];
}
- (void)XPGWifiSDK:(XPGWifiSDK *)wifiSDK didRegisterUser:(NSNumber *)error errorMessage:(NSString *)errorMessage uid:(NSString *)uid token:(NSString *)token {
    // got uid & token if register success
    if (uid.length != 0 && token.length != 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    // otherwise got error code & error message
}

@end
