//
//  LoadingView.h
//  WuZi
//
//  Created by SevenTC on 15/3/18.
//  Copyright (c) 2015年 chenfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView
-  (instancetype)initWithMessage:(NSString *)message;

- (void)cancelLoading;
@end
