//
//  SetWifiView.h
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/8/8.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetWifiView : UIView
@property (nonatomic, copy) void (^setWiFiBlock)(NSString * SSID,NSString * pass);
@end
