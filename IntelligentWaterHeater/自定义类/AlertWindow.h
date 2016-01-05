//
//  AlertWindow.h
//  FindJob
//
//  Created by rimi on 14-12-8.
//  Copyright (c) 2014年 pengjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertWindow : UIView

+ (void) showWithMessage:(NSString *)message canceDelay:(NSTimeInterval)delay;
@end
