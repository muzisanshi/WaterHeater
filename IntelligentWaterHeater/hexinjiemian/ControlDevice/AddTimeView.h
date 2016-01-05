//
//  AddTimeView.h
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/12/15.
//  Copyright © 2015年 dailinli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTimeView : UIView
@property (nonatomic, strong) UIImageView * switchImageView;
@property (nonatomic, strong) UILabel * switchView;
@property (nonatomic, strong) UIImageView * switchImageView1;
@property (nonatomic, strong) UILabel * switchView1;
@property (nonatomic, strong) UIImageView * switchImageView2;
@property (nonatomic, strong) UILabel * switchView2;
@property (nonatomic, strong) UIButton * addBtn;
@property (nonatomic, strong) UIButton * addBtn1;
@property (nonatomic, strong) UIButton * addBtn2;
@property (nonatomic, strong) UIButton * deleteBtn;
@property (nonatomic, strong) UIButton * deleteBtn1;
@property (nonatomic, strong) UIButton * deleteBtn2;


@property (nonatomic,  copy) void (^setTemBlock)();
@property (nonatomic,  copy) void (^cancelBlock)();

@property (nonatomic,  copy) void (^setTemBlock1)();
@property (nonatomic,  copy) void (^cancelBlock1)();

@property (nonatomic,  copy) void (^setTemBlock2)();
@property (nonatomic,  copy) void (^cancelBlock2)();

@property (nonatomic,  copy) void (^tapBlock)();
@property (nonatomic,  copy) void (^tapBlock1)();
@property (nonatomic,  copy) void (^tapBlock2)();

@property (nonatomic , copy) void (^addBlock)();
@property (nonatomic , copy) void (^addBlock1)();
@property (nonatomic , copy) void (^addBlock2)();

@property (nonatomic , copy) void (^longBlock)();
@property (nonatomic , copy) void (^longBlock1)();
@property (nonatomic , copy) void (^longBlock2)();

@end
