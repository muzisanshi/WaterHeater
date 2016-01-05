//
//  SetNumberController.h
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/8/7.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SetNumberDelegate <NSObject>

- (void)setTemperature:(NSString *)temperature from:(int)from;

@end
@interface SetNumberController : UIViewController
@property (nonatomic, copy) NSString * warnString;
@property (nonatomic, assign) id <SetNumberDelegate>delegate;
@property (nonatomic, assign) int from;
@end
