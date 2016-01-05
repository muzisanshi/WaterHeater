//
//  LoginController.m
//  IntelligentWaterHeater
//
//  Created by mac on 15/4/15.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import "LoginController.h"
#import "RegistController.h"
#import "HomePageController.h"
#import "DeviceController.h"
#import "LoginView.h"
@interface LoginController ()<XPGWifiSDKDelegate>{
    LoadingView * loading;
}
@property(nonatomic, strong) LoginView * loginView;
@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    self.view.backgroundColor = kRGBA(24, 153, 152, 1);
    [self initUserInterface];
     loading = [[LoadingView alloc]initWithMessage:@"登录中..."];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [XPGWifiSDK sharedInstance].delegate = self;

}

- (void)initUserInterface
{
    _loginView = [[LoginView alloc]initWithFrame:CGRectMake(0, 64, mScreen.width, mScreen.height - 64-64)];
    [self.view addSubview:_loginView];
    __weak LoginController * loginC = self;
    _loginView.loginBtnBlock = ^{
        [loginC login];
    };
    _loginView.forgetBtnBlokc = ^{
        [loginC forgetPass];
    };
    _loginView.registBtnBlokc = ^{
        [loginC regist];
    };
    
}

#pragma mark -- 登录
- (void)login
{
    [self.view addSubview:loading];
    [[XPGWifiSDK sharedInstance] userLoginWithUserName:_loginView.accountTF password:_loginView.passwordTF];
}
- (void)XPGWifiSDK:(XPGWifiSDK *)wifiSDK didUserLogin:(NSNumber *)error errorMessage:(NSString *)errorMessage uid:(NSString *)uid token:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:_loginView.accountTF forKey:@"username"];
    NSLog(@"uid == %@ token == %@",uid,token);
    if ([error integerValue]==0) {
        [((Userinfo *)[[Userinfo alloc] init]) saveUserInfo:@{@"uid":uid,@"token":token}];
        [self.navigationController pushViewController:[[DeviceController alloc]init] animated:YES];
    }else{
        [AlertWindow showWithMessage:errorMessage canceDelay:1];
    }
    [loading cancelLoading];
}

#pragma mark -- 注册
- (void)regist
{
    [self.navigationController pushViewController:[[RegistController alloc] init] animated:YES];
}

#pragma mark -- 忘记密码
- (void)forgetPass
{
    
}

@end
