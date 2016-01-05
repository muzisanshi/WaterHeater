//
//  LoginView.h
//  IntelligentWaterHeater
//
//  Created by mac on 15/4/15.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView
// 账号文本框
@property (nonatomic , copy) NSString *accountTF;
// 密码文本框
@property (nonatomic, copy) NSString *passwordTF;
// 回调点击事件
@property (nonatomic, copy) void (^loginBtnBlock)();
@property (nonatomic, copy) void (^forgetBtnBlokc)();
@property (nonatomic, copy) void (^registBtnBlokc)();


@end
