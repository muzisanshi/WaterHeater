//
//  BoundDeviceController.m
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/7/30.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import "BoundDeviceController.h"
#import "ScanningCheckController.h"
#import "LocalSetController.h"

#import "SearchDeviceView.h"
#import "SetWifiView.h"
#import "UdpOperation.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "AsyncUdpSocket.h"
@interface BoundDeviceController ()<XPGWifiSDKDelegate,LocalSetDelegate,UIScrollViewDelegate>
{
    NSString * _ssid;
    UIScrollView * scr;
    NSString * _SSID;
    NSString * _pass;
    NSString * _IP;
}
@property (nonatomic, strong) SearchDeviceView * searchDeviceV;
@property (nonatomic, strong) SetWifiView * setWiFiV;
@property(nonatomic,strong)AsyncUdpSocket *udpSocket;

@end

@implementation BoundDeviceController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

// Get IP Address
- (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, mScreen.width, mScreen.height - 64)];
    scr.delegate = self;
    [scr setContentSize:CGSizeMake(mScreen.width*3, mScreen.height - 64)];
    scr.bounces = NO;
    scr.pagingEnabled = YES;
    [self.view addSubview:scr];

    [scr addSubview:self.searchDeviceV];
    [XPGWifiSDK sharedInstance].delegate = self;
    __weak BoundDeviceController * boundVC = self;
    _searchDeviceV.QRCodeBlock = ^{
        [boundVC.navigationController pushViewController:[[ScanningCheckController alloc] init] animated:YES];
    };
    _searchDeviceV.configurationGokitBlock = ^{
        [[XPGWifiSDK sharedInstance] getSSIDList];
    };
    _searchDeviceV.localConfigurationBlock = ^{
      LocalSetController * locaVC=  [[LocalSetController alloc] init];
        locaVC.delegate = boundVC;
        [boundVC.navigationController pushViewController:locaVC animated:YES];
    };
    
    [scr addSubview:self.setWiFiV];
//    [self openUDPServer];
    _setWiFiV.setWiFiBlock  = ^(NSString * SSID,NSString * pass){
        NSLog(@"%@ %@ %@",SSID,pass,[boundVC getIPAddress]);
//        [boundVC localSet:SSID pass:pass];
        _SSID = SSID;
        _pass = pass;
//         [NSThread detachNewThreadSelector:@selector(localSet) toTarget:boundVC withObject:nil];
        
        [boundVC localSet];
    };
    
}

//-(void)openUDPServer{
//    //初始化udp
//    AsyncUdpSocket *tempSocket=[[AsyncUdpSocket alloc] initWithDelegate:self];
//    self.udpSocket=tempSocket;
//    //绑定端口
//    NSError *error = nil;
//    [self.udpSocket bindToPort:6000 error:&error];
//    
//    //发送广播设置
//    [self.udpSocket enableBroadcast:YES error:&error];
//    
//    //加入群里，能接收到群里其他客户端的消息
//    [self.udpSocket joinMulticastGroup:[self getIPAddress] error:&error];
//    
//   	//启动接收线程
//    [self.udpSocket receiveWithTimeout:-1 tag:0];
//    
//}

- (void)localSet
{
//    NSDate *nowTime = [NSDate date];
//    
//    NSMutableString *sendString=[NSMutableString stringWithCapacity:100];
//    [sendString appendString:@"123123minimin"];
//    //开始发送
//    BOOL res = [self.udpSocket sendData:[sendString dataUsingEncoding:NSUTF8StringEncoding]
//                                 toHost:@"255.255.255.255"
//                                   port:6000
//                            withTimeout:-1
//                
//                                    tag:0];

//    while (1) {
    
    
//    [NSThread detachNewThreadSelector:@selector(threadAction) toTarget:self withObject:nil];
//    [self threadAction];
    UdpOperation * udp = [[UdpOperation alloc]initWithIp:[self getIPAddress]];
    ////    udp.udpSocket = _udpSocket;
    //    udp.sendDataBlock = ^{
    //
    //    };
    [udp sendData:(char *)[_SSID UTF8String] pass:(char *)[_pass UTF8String] ip:(char *)[[self getIPAddress] UTF8String] info:(char *)[@"aa" UTF8String]];
    //    }

}

- (void)threadAction
{
    UdpOperation * udp = [[UdpOperation alloc]initWithIp:[self getIPAddress]];
    ////    udp.udpSocket = _udpSocket;
    //    udp.sendDataBlock = ^{
    //
    //    };
    [udp sendData:(char *)[_SSID UTF8String] pass:(char *)[_pass UTF8String] ip:(char *)[[self getIPAddress] UTF8String] info:(char *)[@"aa" UTF8String]];
    //    }

}
-(SearchDeviceView *)searchDeviceV
{
    if (!_searchDeviceV) {
        _searchDeviceV = [[SearchDeviceView alloc]initWithFrame:CGRectMake(0, 0, mScreen.width, mScreen.height - 64)];
    }
    return _searchDeviceV;
}

-(SetWifiView *)setWiFiV
{
    if (!_setWiFiV) {
        _setWiFiV = [[SetWifiView alloc]initWithFrame:CGRectMake(mScreen.width, 0, mScreen.width, mScreen.height - 64)];
    }
    return _setWiFiV;
}

- (void)XPGWifiSDK:(XPGWifiSDK *)wifiSDK didGetSSIDList:(NSArray *)ssidList result:(int)result;
{
    NSLog(@"ssidList == %@",ssidList);
}


-(void)SSID:(NSString *)ssid
{
    
    [scr setContentOffset:CGPointMake(mScreen.width, 0) animated:YES];
    ((UITextField *)[_setWiFiV viewWithTag:31]).text = ssid;
    _ssid = ssid;
}
@end
