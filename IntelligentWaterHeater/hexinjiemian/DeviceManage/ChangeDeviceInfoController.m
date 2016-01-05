//
//  ChangeDeviceInfoController.m
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/10/21.
//  Copyright © 2015年 dailinli. All rights reserved.
//

#import "ChangeDeviceInfoController.h"
#import <XPGWifiSDK/XPGWifiSDK.h>
@interface ChangeDeviceInfoController ()<UITextFieldDelegate,XPGWifiSDKDelegate>
{
    UITextField * textFiled;
}
@end

@implementation ChangeDeviceInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightItemAction)];
    
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, mScreen.width - 30, 30)];
    label.textColor = [UIColor lightGrayColor];
    label.text = @"名称";
    [self.view addSubview:label];
    
    textFiled = [[UITextField alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(label.frame)+5, mScreen.width - 60, 40)];
    [textFiled setBorderStyle:UITextBorderStyleRoundedRect];
    textFiled.delegate = self;
    textFiled.placeholder = self.title;
    [self.view addSubview:textFiled];
    
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(50, mScreen.height - 64 - 100, mScreen.width - 100, 50)];
    [button setBackgroundColor:kRGBADefault];
    [button setTitle:@"删除设备" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
    [button addTarget:self action:@selector(deleteAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    [XPGWifiSDK sharedInstance].delegate = self;
    
}

- (void)rightItemAction
{
    if (textFiled.text.length != 0 ) {
        
    }
}
- (void)deleteAction
{
    [[XPGWifiSDK sharedInstance] unbindDeviceWithUid:[Userinfo currentUser].uid token:[Userinfo currentUser].token did:_did passCode:nil];
}
- (void)XPGWifiSDK:(XPGWifiSDK *)wifiSDK didUnbindDevice:(NSString *)did error:(NSNumber *)error errorMessage:(NSString *)errorMessage;
{

    if ([error integerValue] == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [AlertWindow showWithMessage:errorMessage canceDelay:1];

    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}
@end
