//
//  CircleSlider.h
//  CircleSlider
//
//  Created by cyl on 15/12/20.
//  Copyright © 2015年 OopsStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControlDeviceController.h"

@class CircleSlider;

@protocol CircleSliderDelegate <NSObject>

@optional
- (void)circleSliderValueChanged:(CircleSlider *)circleSlider;
- (void)circleSliderBoxChanged:(CircleSlider *)circleSlider;
- (void)onTouchEnd:(CircleSlider *)circleSlider;

@end

@interface CircleSlider : UIView

@property (nonatomic, weak) id<CircleSliderDelegate> delegate;
@property (nonatomic, weak) ControlDeviceController *conInstance;
@property (nonatomic, assign) int value;
@property (nonatomic, assign) int sliderValue;

@property (nonatomic, assign) BOOL isWaterBox;
@property (nonatomic, assign) BOOL isShowColorfulGraduation;

@property UIImage *but;
@property UIButton *butView;

@property BOOL isToDraw;

-(void)onClick;
@end
