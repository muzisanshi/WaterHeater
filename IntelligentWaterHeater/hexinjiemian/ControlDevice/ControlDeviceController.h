//
//  ControlDeviceController.h
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/7/31.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ControlDeviceController : UIViewController<XPGWifiDeviceDelegate,XPGWifiSDKDelegate>
@property(nonatomic, strong)XPGWifiDevice * device;
@end
