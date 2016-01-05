//
//  SetTimeAndTemView.h
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/11/4.
//  Copyright © 2015年 dailinli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetTimeAndTemView : UIView
@property (nonatomic ,strong)UILabel * temLabel;
@property (nonatomic ,copy) void (^sureBlock)(NSString * timeString,NSDate * date);
@end
