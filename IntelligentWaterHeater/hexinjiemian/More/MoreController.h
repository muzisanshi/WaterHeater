//
//  MoreController.h
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/8/5.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreController : UIViewController<XPGWifiDeviceDelegate,XPGWifiSDKDelegate>
@property(nonatomic, strong)XPGWifiDevice * device;

@end
