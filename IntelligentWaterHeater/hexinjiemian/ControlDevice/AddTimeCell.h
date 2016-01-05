//
//  AddTimeCell.h
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/10/21.
//  Copyright © 2015年 dailinli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTimeCell : UITableViewCell
@property (nonatomic, strong) UIButton * addBtn;
@property (nonatomic, strong) UILabel * timeLable;
@property (nonatomic, strong) UIImageView * switchImageView;
@property (nonatomic, strong) UILabel * switchView;

@property (nonatomic,  copy) void (^setTemBlock)();
@property (nonatomic,  copy) void (^cancelBlock)();
@property (nonatomic , copy) void (^addBlock)();
@end
