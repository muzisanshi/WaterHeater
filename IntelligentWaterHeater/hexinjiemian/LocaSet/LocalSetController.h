//
//  LocalSetController.h
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/8/7.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LocalSetDelegate <NSObject>

- (void)SSID:(NSString *)ssid;

@end
@interface LocalSetController : UIViewController
@property (nonatomic, assign) id <LocalSetDelegate>delegate;
@end
