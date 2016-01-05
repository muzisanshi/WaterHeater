//
//  LeftChooseActionBtn.h
//  Sneez
//
//  Created by mac on 15/5/21.
//  Copyright (c) 2015年 dll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftChooseActionBtn : UIButton
@property (nonatomic, copy) void (^processAction)();
- (instancetype)initWithFrame:(CGRect)frame nomalImage:(NSString *)normalImage higlhtImage:(NSString *)higlhtImage;
- (instancetype)initWithFrame:(CGRect)frame name:(NSString *)name;

@end
