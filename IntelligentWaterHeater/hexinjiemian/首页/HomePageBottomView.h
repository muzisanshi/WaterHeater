//
//  HomePageBottomView.h
//  IntelligentWaterHeater
//
//  Created by mac on 15/4/11.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageBottomView : UIView
@property (nonatomic, copy) void (^helpBlock)();
@property (nonatomic, copy) void (^aboutBlock)();
@end
