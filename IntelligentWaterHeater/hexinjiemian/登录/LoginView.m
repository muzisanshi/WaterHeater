//
//  LoginView.m
//  IntelligentWaterHeater
//
//  Created by mac on 15/4/15.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import "LoginView.h"
@interface LoginView()<UITextFieldDelegate>

@property (nonatomic, strong)UITextField *accountTextField;
@property (nonatomic, strong)UITextField *passwordTextField;

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 账号密码文本框
        [self addSubview:self.accountTextField];
        [self addSubview:self.passwordTextField];
        
        // 登陆按钮
        [self addLoginBtn];
    }
    return self;
}
// 添加账号密码输入框
#pragma mark 账号
- (UITextField *)accountTextField
{
    if (!_accountTextField) {
        _accountTextField = [[UITextField alloc] init];
        _accountTextField.frame = CGRectMake(0.2*mScreen.width, 30, 0.7*mScreen.width, 30);
        _accountTextField.placeholder = @"手机号、邮箱或者ID号";
//        _accountTextField.text = @"18728443672";
        _accountTextField.delegate = self;
        _accountTextField.font = [UIFont systemFontOfSize:16];
        [_accountTextField setReturnKeyType:UIReturnKeyNext];
        [_accountTextField setClearButtonMode:UITextFieldViewModeAlways];
        UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(0.1*mScreen.width, 30+(30-0.05*mScreen.width)/2, 0.05*mScreen.width, 0.05*mScreen.width)];
        image.image = [UIImage imageNamed:@"login_name"];
        [self addSubview:image];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(image.frame), CGRectGetMaxY(_accountTextField.frame)-1, 0.8*mScreen.width, 1)];
        label.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.4];
        [self addSubview:label];
        
    }
    return _accountTextField;
}

#pragma mark 密码
- (UITextField *)passwordTextField
{
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.frame = CGRectMake(0.2*mScreen.width, CGRectGetMaxY(_accountTextField.frame)+10, 0.7*mScreen.width, 30);
        _passwordTextField.placeholder = @"输入登录密码";
        _passwordTextField.delegate = self;
//        _passwordTextField.text = @"Li8728428850";
        _passwordTextField.font = [UIFont systemFontOfSize:16];
        _passwordTextField.secureTextEntry = YES;
        [_passwordTextField setReturnKeyType:(UIReturnKeyGo)];
        UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(0.1*mScreen.width, CGRectGetMaxY(_accountTextField.frame)+10+(30-0.05*mScreen.width)/2, 0.05*mScreen.width, 0.05*mScreen.width)];
        image.image = [UIImage imageNamed:@"login_pass"];
        [self addSubview:image];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(image.frame), CGRectGetMaxY(_passwordTextField.frame)-1, 0.8*mScreen.width, 1)];
        label.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.4];
        [self addSubview:label];
    }
    return _passwordTextField;
}

#pragma mark 添加登陆按钮
- (void)addLoginBtn
{
    
    UIButton * forgetBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_passwordTextField.frame) - 80, CGRectGetMaxY(_passwordTextField.frame)+10, 80, 15)];
    [forgetBtn addTarget:self action:@selector(processforgetBtn) forControlEvents:(UIControlEventTouchUpInside)];
    forgetBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [forgetBtn setTitleEdgeInsets:(UIEdgeInsetsMake(0, 10, 0, -10))];
    [forgetBtn setTitle:@"忘记密码" forState:(UIControlStateNormal)];
    [forgetBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    forgetBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:forgetBtn];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(mScreen.width*0.1, CGRectGetMaxY(forgetBtn.frame)+15, mScreen.width*0.8, 40);
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn.png"] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
    loginBtn.backgroundColor = [UIColor yellowColor];
    [loginBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [loginBtn addTarget:self action:@selector(lgoinBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginBtn];

    
    UIButton * registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(loginBtn.frame), CGRectGetMaxY(loginBtn.frame)+10, CGRectGetWidth(loginBtn.frame), CGRectGetHeight(loginBtn.frame))];
    [registerBtn addTarget:self action:@selector(processRegistBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [registerBtn setTitle:@"免费注册" forState:(UIControlStateNormal)];
    [registerBtn setBackgroundColor:[UIColor yellowColor]];
    [registerBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [registerBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateHighlighted)];
//    registerBtn.titleLabel.textAlignment = NSTextAlignmentRight;
//    registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:registerBtn];

    
}

#pragma mark 监听按钮点击事件
- (void)lgoinBtn
{
    self.accountTF = _accountTextField.text;
    self.passwordTF = _passwordTextField.text;
    if (self.loginBtnBlock) {
        self.loginBtnBlock();
    }
}

- (void)processforgetBtn
{
    if (self.forgetBtnBlokc) {
        self.forgetBtnBlokc();
    }
}

- (void)processRegistBtn
{
    if (self.registBtnBlokc) {
        self.registBtnBlokc();
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _accountTextField) {
        [_passwordTextField becomeFirstResponder];
    }else if (textField == _passwordTextField){
        [self lgoinBtn];
    }
    [textField resignFirstResponder];
    return YES;
}


@end
