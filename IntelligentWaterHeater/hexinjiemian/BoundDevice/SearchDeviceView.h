//
//  SearchDeviceView.h
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/7/30.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchDeviceView : UIView
@property (nonatomic, copy) void (^QRCodeBlock)();
@property (nonatomic, copy) void (^configurationGokitBlock)();
@property (nonatomic, copy) void (^localConfigurationBlock)();

@end
