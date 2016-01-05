//
//  HomePageController.m
//  IntelligentWaterHeater
//
//  Created by mac on 15/4/11.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import "HomePageController.h"

#import "HomePageBottomView.h"
@interface HomePageController ()<XPGWifiSDKDelegate,XPGWifiDeviceDelegate>
{
}
@property (nonatomic, strong) HomePageBottomView * homePageBottomV;

@end

@implementation HomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRGBA(100, 152, 182, 1);
    self.title = @"智能热水器";
    [self initUserInterface];
    [XPGWifiSDK sharedInstance].delegate = self;
    
    [[XPGWifiSDK sharedInstance] getSSIDList];
    [[XPGWifiSDK sharedInstance] getBoundDevicesWithUid:[Userinfo currentUser].uid token:[Userinfo currentUser].token specialProductKeys: @"e7da181a7a5547199a82c92a0343bd27",nil];
//    XPGWifiDevice * device = [[XPGWifiDevice alloc]init];
//    device.delegate = self;
//    [device write:nil];
//    //设备登陆
//    [device login:[Userinfo currentUser].uid token:[Userinfo currentUser].token];
//    
//    [device getHardwareInfo];

    [[XPGWifiSDK sharedInstance] setDeviceWifi:@"nimeinimei" key:@"jumeiyouping" mode:XPGWifiSDKSoftAPMode softAPSSIDPrefix:@"nimeinimei" timeout:30];
//    [[XPGWifiSDK sharedInstance] bindDeviceWithUid:[Userinfo currentUser].uid token:[Userinfo currentUser].token did:device.did passCode:device.passcode remark:nil];
    
}
- (void)XPGWifiSDK:(XPGWifiSDK *)wifiSDK didSetDeviceWifi:(XPGWifiDevice *)device result:(int)result {
    if (result == 0) {
        // successfully
    }
    else {
        // handle failed or timeout
    }
    NSLog(@"device111 == %@",device);
    NSLog(@"result111 == %d",result);
}


- (void)initUserInterface
{
    __weak HomePageController * homePageVC  = self;
    _homePageBottomV = [[HomePageBottomView alloc]initWithFrame:CGRectMake(0, mScreen.height-50-64, mScreen.width, 50)];
    _homePageBottomV.helpBlock = ^{
        [homePageVC helpPressed];
    };
    _homePageBottomV.aboutBlock = ^{
        [homePageVC aboutPressed];
    };
    [self.view addSubview:_homePageBottomV];
    
    UIButton * connect = [[UIButton alloc]initWithFrame:CGRectMake(mScreen.width/6, (mScreen.height - 64)*0.7, mScreen.width*2/3, 40)];
    connect.backgroundColor = [UIColor blackColor];
    [connect setTitle:@"添加新设备" forState:(UIControlStateNormal)];
    [connect setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
    [self.view addSubview:connect];
}

#pragma mark -- 帮助
- (void)helpPressed
{
    
}
#pragma mark -- 关于
- (void)aboutPressed
{
    
}
#pragma mark -- XPGDelegate
- (void)XPGWifiSDK:(XPGWifiSDK *)wifiSDK didGetSSIDList:(NSArray *)ssidList result:(int)result {
    if (result == 0) {
        // handle returned ssid list
    }
    NSLog(@"ssidList == %@",ssidList);
    NSLog(@"result == %d",result);
}
- (void)XPGWifiSDK:(XPGWifiSDK *)wifiSDK didDiscovered:(NSArray *)deviceList result:(int)result {
    if (result == 0) {
        // discovery successfully, handle deviceList
        for(XPGWifiDevice *device in deviceList) {
            NSLog(@"device == %@",device);
    
        }
        NSLog(@"deviceList == %@",deviceList);

    }
    NSLog(@"result == %d",result);
}
#pragma mark -- 设备登陆或断开

- (void)XPGWifiDevice:(XPGWifiDevice *)device didLogin:(int)result {
    if (result == 0) {
        NSLog(@" login successfully, handle device");
    }
    else if (result == 2) {
        NSLog(@" login failed");
    }
}

- (void)XPGWifiDeviceDidDisconnected:(XPGWifiDevice *)device {
    // device connection closed, handle the device
}

- (BOOL)XPGWifiDevice:(XPGWifiDevice *)device didReceiveData:(NSDictionary*)data {
    return YES;
}
@end
