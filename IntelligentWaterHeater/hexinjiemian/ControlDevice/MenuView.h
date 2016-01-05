//
//  MenuView.h
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/7/31.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuView : UIView
@property (nonatomic, copy) void (^moreSetBlock)();
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;
@end
