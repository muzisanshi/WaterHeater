//
//  SetTimeTemperatureController.h
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/8/5.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SetTimeTemperatureDelegate <NSObject>

- (void)setStartTime:(NSString *)startTime endTime:(NSString *)endTime temperature:(NSString *)temperature from:(int)from;

@end
@interface SetTimeTemperatureController : UIViewController
@property (nonatomic,assign) id <SetTimeTemperatureDelegate> delegate;
@property (nonatomic,assign) int from;
@end
