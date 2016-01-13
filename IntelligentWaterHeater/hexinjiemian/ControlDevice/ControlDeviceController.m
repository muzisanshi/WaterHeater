//
//  ControlDeviceController.m
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/7/31.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import "ControlDeviceController.h"
#import "SetTimeTemperatureController.h"
#import "MoreController.h"
#import "EFCircularSlider.h"
#import "MenuView.h"
#import "AddTimeCell.h"
#import "SetTimeAndTemView.h"
#import "AddTimeView.h"
#import "CircleSlider.h"
#import "NSString+TimeStampStandardTime.h"
#import "NSString+TimeTurnTimeStamp.h"
@interface ControlDeviceController ()<UITableViewDataSource,UITableViewDelegate,SetTimeTemperatureDelegate,CircleSliderDelegate>
{
    NSInteger _count;
    UILabel * _promptLable;
    BOOL _isLast;
    NSInteger _row;
    UIButton * rightItem;
    CircleSlider * _cirleSilder;
    NSDictionary * _deviceInfo;
}
@property (nonatomic, strong) MenuView * menuView;
@property (nonatomic, strong) SetTimeAndTemView * setTimeAndTemView;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) AddTimeView * addTimeView;

@end

@implementation ControlDeviceController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _device.delegate = nil;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"controlDeivce" object:nil];
}

- (void)viewDidLoad {
    NSLog(@"ControlDeviceController------------viewDidLoad()");
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.965f green:0.965f blue:0.965f alpha:1.00f];
    
    __unsafe_unretained typeof(self) weakSelf = self;
    
    _isLast = NO;
    _device.delegate = self;
    [_device login:[Userinfo currentUser].uid token:[Userinfo currentUser].token];
    _count= 0;
    _menuView = [[MenuView alloc]initWithFrame:CGRectMake(-mScreen.width, 0, mScreen.width, mScreen.height ) title:self.title];
    __weak ControlDeviceController * controlVC = self;
    
    _menuView.moreSetBlock =  ^{
        [controlVC rightAction];
    };
    [self initUserInterface];
    [self.view addSubview:_menuView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controlDeivce:) name:@"controlDeivce" object:nil];
    
    _setTimeAndTemView = [[SetTimeAndTemView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _setTimeAndTemView.sureBlock = ^(NSString * timeString,NSDate * date){
        if (_row == 0) {

            NSDictionary * dict = @{@"entity0":@{@"Time_appointment_hour1":[timeString substringWithRange:NSMakeRange(11, 2)],@"Time_appointment_minute1":[timeString substringWithRange:NSMakeRange(14, 2)],@"Time_appointment_Temp1":weakSelf->_setTimeAndTemView.temLabel.text},@"cmd":@1};
            [weakSelf->_device write:dict];
            
            if (weakSelf->_cirleSilder.value < [weakSelf->_setTimeAndTemView.temLabel.text intValue]) {
                
                NSInteger time = 4200*100*([weakSelf->_setTimeAndTemView.temLabel.text intValue] - weakSelf->_cirleSilder.value )/(1500*0.98);
                
              weakSelf->_addTimeView.switchView.text = [NSString stringWithFormat:@"%@到达%@℃",[[NSString TimeStampStandardTimeWithTimeStamp:[NSString stringWithFormat:@"%ld",[[NSString timeToTurnTimeStamp:date] integerValue] + time]] substringWithRange:NSMakeRange(11, 5)] ,weakSelf->_setTimeAndTemView.temLabel.text];
//                _promptLable.hidden = NO;
            }else{
//                _promptLable.hidden = YES;
            }

        }else if (_row == 1){
            NSDictionary * dict = @{@"entity0":@{@"Time_appointment_hour2":[timeString substringWithRange:NSMakeRange(11, 2)],@"Time_appointment_minute2":[timeString substringWithRange:NSMakeRange(14, 2)],@"Time_appointment_Temp2":weakSelf->_setTimeAndTemView.temLabel.text},@"cmd":@1};
            [weakSelf->_device write:dict];
            if (weakSelf->_cirleSilder.value < [weakSelf->_setTimeAndTemView.temLabel.text intValue]) {
                
                NSInteger time = 4200*100*([weakSelf->_setTimeAndTemView.temLabel.text intValue] - weakSelf->_cirleSilder.value )/(1500*0.98);
                weakSelf->_addTimeView.switchView1.text = [NSString stringWithFormat:@"%@到达%@℃",[[NSString TimeStampStandardTimeWithTimeStamp:[NSString stringWithFormat:@"%ld",[[NSString timeToTurnTimeStamp:date] integerValue] + time]] substringWithRange:NSMakeRange(11, 5)] ,weakSelf->_setTimeAndTemView.temLabel.text];
                //                _promptLable.hidden = NO;
            }else{
                //                _promptLable.hidden = YES;
            }

        }else {
            NSDictionary * dict = @{@"entity0":@{@"Time_appointment_hour3":[timeString substringWithRange:NSMakeRange(11, 2)],@"Time_appointment_minute3":[timeString substringWithRange:NSMakeRange(14, 2)],@"Time_appointment_Temp3":weakSelf->_setTimeAndTemView.temLabel.text},@"cmd":@1};
            [weakSelf->_device write:dict];
            if (weakSelf->_cirleSilder.value < [weakSelf->_setTimeAndTemView.temLabel.text intValue]) {
                
                NSInteger time = 4200*100*([weakSelf->_setTimeAndTemView.temLabel.text intValue] - weakSelf->_cirleSilder.value )/(1500*0.98);
                weakSelf->_addTimeView.switchView2.text = [NSString stringWithFormat:@"%@到达%@℃",[[NSString TimeStampStandardTimeWithTimeStamp:[NSString stringWithFormat:@"%ld",[[NSString timeToTurnTimeStamp:date] integerValue] + time]] substringWithRange:NSMakeRange(11, 5)] ,weakSelf->_setTimeAndTemView.temLabel.text];
                //                _promptLable.hidden = NO;
            }else{
                //                _promptLable.hidden = YES;
            }

        }
    };

}
- (void)XPGWifiDevice:(XPGWifiDevice *)device didQueryHardwareInfo:(NSDictionary *)hwInfo;
{
    NSLog(@"hwInfo == %@",hwInfo);
}
- (void)controlDeivce:(NSNotification *)notice
{
    [_device write:[notice userInfo]];
    
}
- (void)XPGWifiDevice:(XPGWifiDevice *)device didLogin:(int)result;
{
    NSLog(@"device login == %d",result);
    if (result == 0) {
        [_device getHardwareInfo];
        [_device write:@{@"cmd":@2}];
    }
}

- (void)rightAction
{
    MoreController * moreVC= [[MoreController alloc] init];
    moreVC.device = _device;
    [self.navigationController pushViewController:moreVC animated:YES];
}

- (void)rightItemActionWithIsOn:(UIButton *)sender{
    sender.selected = !sender.selected;
    [_device write:@{@"entity0":@{@"Switch":sender.selected == YES ? @1 :@0},@"cmd":@1}];
    if (sender.selected == YES) {
        _promptLable.hidden = NO;
//        _tableView.hidden = YES;
        _addTimeView.hidden = NO;
    }else {
        _promptLable.hidden = YES;
//        _tableView.hidden = NO;
        _addTimeView.hidden = YES;
    }
}

- (void)leftAction
{
        [UIView animateWithDuration:0.3 animations:^{
            _menuView.frame = CGRectMake(0, 0, mScreen.width, mScreen.height);
        }];
}

// 下面的两个函数是处理温度控件滑动条的
//- (void)circleSliderValueChanged:(CircleSlider *)circleSlider{
//    NSLog(@"调用了circleSliderValueChanged()函数");
//}
- (void)circleSliderBoxChanged:(CircleSlider *)circleSlider{
    NSLog(@"调用了circleSliderBoxChanged()函数");
}

- (void)initUserInterface
{
    
    UIButton * leftItem = [[UIButton alloc] initWithFrame:CGRectMake(30, 25, 40, 40)];
    [leftItem setImage:[UIImage imageNamed:@"zhuti1.png"] forState:(UIControlStateNormal)];
    [leftItem setImage:[UIImage imageNamed:@"zhuti.png"] forState:(UIControlStateHighlighted)];
    [leftItem addTarget:self action:@selector(leftAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:leftItem];
    
    rightItem = [[UIButton alloc] initWithFrame:CGRectMake(mScreen.width-70, 25, 40, 40)];
    [rightItem setImage:[UIImage imageNamed:@"figure_light_close.png"] forState:(UIControlStateNormal)];
    [rightItem setImage:[UIImage imageNamed:@"figure_light_green.png"] forState:(UIControlStateSelected)];
    [rightItem addTarget:self action:@selector(rightItemActionWithIsOn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:rightItem];

    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 , 125, 24)];
    imageView.center = CGPointMake(mScreen.width/2, 45);
    imageView.image = [UIImage imageNamed:@"logoguang.png"];
    [self.view addSubview:imageView];
    
    _promptLable = [[UILabel alloc] initWithFrame:CGRectMake(30, 10+64, mScreen.width - 60, 40)];
    _promptLable.textColor = [UIColor grayColor];
    _promptLable.textAlignment = NSTextAlignmentCenter;
//    _promptLable.text = @"预计明天05:33到达89°";
    _promptLable.hidden = YES;
    [self.view addSubview:_promptLable];
    
    
    
    // 初始化温度控件
    _cirleSilder = [[CircleSlider alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(_promptLable.frame), mScreen.width-50, mScreen.width-50)];
    _cirleSilder.delegate = self;
    _cirleSilder.backgroundColor = [UIColor clearColor];
    _cirleSilder.isShowColorfulGraduation = NO;
    [self.view addSubview:_cirleSilder];
    
    

    __unsafe_unretained typeof(self) selfBlock = self;
    _addTimeView = [[AddTimeView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_cirleSilder.frame), mScreen.width, mScreen.height -CGRectGetMaxY(_cirleSilder.frame)-20 )];
    _addTimeView.setTemBlock = ^{
        NSDictionary * dict = @{@"entity0":@{@"Time_of_appointment1":@1},@"cmd":@1};
        [selfBlock->_device write:dict];
        [selfBlock.view addSubview:selfBlock->_setTimeAndTemView];
        _row = 0;
    };
    _addTimeView.cancelBlock = ^{
        NSDictionary * dict = @{@"entity0":@{@"Time_of_appointment1":@0},@"cmd":@1};
        [selfBlock->_device write:dict];
    };
    
    _addTimeView.setTemBlock1 = ^{
        NSDictionary * dict = @{@"entity0":@{@"Time_of_appointment2":@1},@"cmd":@1};
        [selfBlock->_device write:dict];
        [selfBlock.view addSubview:selfBlock->_setTimeAndTemView];
        _row = 1;
    };
    _addTimeView.cancelBlock1 = ^{
        NSDictionary * dict = @{@"entity0":@{@"Time_of_appointment2":@0},@"cmd":@1};
        [selfBlock->_device write:dict];
    };
    
    _addTimeView.setTemBlock2 = ^{
        NSDictionary * dict = @{@"entity0":@{@"Time_of_appointment3":@1},@"cmd":@1};
        [selfBlock->_device write:dict];
        [selfBlock.view addSubview:selfBlock->_setTimeAndTemView];
        _row = 2;
        
    };
    _addTimeView.cancelBlock2 = ^{
        NSDictionary * dict = @{@"entity0":@{@"Time_of_appointment3":@0},@"cmd":@1};
        [selfBlock->_device write:dict];
    };

    _addTimeView.tapBlock = ^{
        [selfBlock.view addSubview:selfBlock->_setTimeAndTemView];

    };
    _addTimeView.tapBlock1 = ^{
        [selfBlock.view addSubview:selfBlock->_setTimeAndTemView];
        
    };
    _addTimeView.tapBlock2 = ^{
        [selfBlock.view addSubview:selfBlock->_setTimeAndTemView];
        
    };
    _addTimeView.addBlock = ^{
        selfBlock->_addTimeView.addBtn.hidden = YES;
        selfBlock->_addTimeView.addBtn1.hidden = NO;
        selfBlock->_addTimeView.addBtn2.hidden = YES;
        selfBlock->_addTimeView.switchImageView.hidden = NO;
        selfBlock->_addTimeView.switchImageView1.hidden = YES;
        selfBlock->_addTimeView.switchImageView2.hidden = YES;
        _count = 1;

    };
    _addTimeView.addBlock1= ^{
        selfBlock->_addTimeView.addBtn.hidden = YES;
        selfBlock->_addTimeView.addBtn1.hidden = YES;
        selfBlock->_addTimeView.addBtn2.hidden = NO;
        selfBlock->_addTimeView.switchImageView.hidden = NO;
        selfBlock->_addTimeView.switchImageView1.hidden = NO;
        selfBlock->_addTimeView.switchImageView2.hidden = YES;
        _count = 2;

    };
    _addTimeView.addBlock2 = ^{
        selfBlock->_addTimeView.addBtn.hidden = YES;
        selfBlock->_addTimeView.addBtn1.hidden = YES;
        selfBlock->_addTimeView.addBtn2.hidden = YES;
        selfBlock->_addTimeView.switchImageView.hidden = NO;
        selfBlock->_addTimeView.switchImageView1.hidden = NO;
        selfBlock->_addTimeView.switchImageView2.hidden = NO;
        _count = 3;


    };
    
    _addTimeView.longBlock = ^{
        if (_count == 3) {
            selfBlock->_addTimeView.addBtn2.hidden = NO;
            selfBlock->_addTimeView.switchImageView2.hidden = YES;
            selfBlock->_addTimeView.deleteBtn.hidden = YES;
            _count = 2;
        }else if (_count == 2){
            selfBlock->_addTimeView.addBtn1.hidden = NO;
            selfBlock->_addTimeView.addBtn2.hidden = YES;

            selfBlock->_addTimeView.switchImageView1.hidden = YES;
            selfBlock->_addTimeView.deleteBtn.hidden = YES;
            _count = 1;
        }else if (_count == 1){
            selfBlock->_addTimeView.addBtn.hidden = NO;
            selfBlock->_addTimeView.addBtn1.hidden = YES;
            selfBlock->_addTimeView.addBtn2.hidden = YES;

            selfBlock->_addTimeView.switchImageView.hidden = YES;
            selfBlock->_addTimeView.deleteBtn.hidden = YES;
            _count = 0;

        }
    };
    _addTimeView.longBlock1 = ^{
        if (_count == 3) {
            selfBlock->_addTimeView.addBtn2.hidden = NO;
            selfBlock->_addTimeView.switchImageView2.hidden = YES;
            selfBlock->_addTimeView.deleteBtn1.hidden = YES;
            _count = 2;
        }else if (_count == 2){
            selfBlock->_addTimeView.addBtn1.hidden = NO;
            selfBlock->_addTimeView.addBtn2.hidden = YES;

            selfBlock->_addTimeView.switchImageView1.hidden = YES;
            selfBlock->_addTimeView.deleteBtn1.hidden = YES;
            _count = 1;

        }
    };
    _addTimeView.longBlock2 = ^{
        selfBlock->_addTimeView.addBtn2.hidden = NO;
        selfBlock->_addTimeView.switchImageView2.hidden = YES;
        selfBlock->_addTimeView.deleteBtn2.hidden = YES;
    };
    _addTimeView.backgroundColor = [UIColor colorWithRed:0.965f green:0.965f blue:0.965f alpha:1.00f];
    
    [self.view addSubview:_addTimeView];
    
}


- (void)timeText
{
    ((UILabel *)[self.view viewWithTag:40]).text = [[NSString stringWithFormat:@"%@",[[NSDate date] dateByAddingTimeInterval:3600*8]] substringWithRange:NSMakeRange(11, 8)];
}

- (BOOL)XPGWifiDevice:(XPGWifiDevice *)device didReceiveData:(NSDictionary *)data result:(int)result;
{
    NSLog(@"收到了机智云返回的数据");
    //基本数据，与发送的数据格式⼀一致
    NSDictionary *_data = [data valueForKey:@"data"];
        
    //警告
    NSArray *alarms = [data valueForKey:@"alarms"];
    
    //错误
    NSArray *faults = [data valueForKey:@"faults"];
    
    //透传数据
    NSDictionary *binary = [data valueForKey:@"binary"];

    NSLog(@"data == %@",_data);
//    [((UISwitch *)[self.view viewWithTag:300]) setOn:[_data[@"entity0"][@"Switch"] integerValue] == 1 ?YES:NO animated:YES];
    
    // 热水器开
    if ([_data[@"entity0"][@"Switch"] integerValue] == YES) {
        _addTimeView.hidden = NO;
        _promptLable.hidden = NO;
        ((UIButton *)self.navigationItem.rightBarButtonItem.customView).selected = YES;
        rightItem.selected = YES;
        
    // 热水器关
    }else {
        _addTimeView.hidden = YES;
        _promptLable.hidden = YES;
        ((UIButton *)self.navigationItem.rightBarButtonItem.customView).selected = NO;
        rightItem.selected = NO;
    }
    
    
    ((NSString *)_data[@"entity0"][@"Time1close_minutes"]).length ==1?[NSString stringWithFormat:@"0%@",_data[@"entity0"][@"Time1close_minutes"]]: _data[@"entity0"][@"Time1close_minutes"];
    
//    if ([_data[@"cmd"] integerValue] == 3) {
    _deviceInfo = _data[@"entity0"];
    _cirleSilder.value = [_deviceInfo[@"Tank_temp"] intValue];
    _cirleSilder.sliderValue = [_deviceInfo[@"Temp_electric_heating"] intValue] ;

    
    if (_cirleSilder.sliderValue > _cirleSilder.value) {
        NSInteger time = 4200*100*(_cirleSilder.sliderValue - _cirleSilder.value)/(1500*0.98);
        
        _promptLable.text = [NSString stringWithFormat:@"预计%@到达%@℃",[[NSString TimeStampStandardTimeWithTimeStamp:[NSString stringWithFormat:@"%ld",[[NSString timeToTurnTimeStamp:[NSDate date]] integerValue] + time]] substringWithRange:NSMakeRange(11, 5)] ,_deviceInfo[@"Temp_electric_heating"]];
        _promptLable.hidden = NO;
    }else{
        _promptLable.hidden = YES;
    }

    if ([_deviceInfo[@"Time_appointment_Temp1"] integerValue] > [_deviceInfo[@"Tank_temp"] integerValue]) {
        
        NSInteger time = 4200*100*([_deviceInfo[@"Time_appointment_Temp1"] intValue] - [_deviceInfo[@"Tank_temp"] integerValue] )/(1500*0.98) + [_deviceInfo[@"Time_appointment_hour1"] integerValue]*3600 +[_deviceInfo[@"Time_appointment_minute1"] integerValue]*60 ;
        
        _addTimeView.switchView.text = [NSString stringWithFormat:@"%@到达%@℃",[[NSString TimeStampStandardTimeWithTimeStamp:[NSString stringWithFormat:@"%ld",time- 8*3600]] substringWithRange:NSMakeRange(11, 5)] ,_deviceInfo[@"Time_appointment_Temp1"]];
        //                _promptLable.hidden = NO;
    }else{
        //                _promptLable.hidden = YES;
    }

    
    if ([_deviceInfo[@"Time_appointment_Temp2"] integerValue] > [_deviceInfo[@"Tank_temp"] integerValue]) {
        
        NSInteger time = 4200*100*([_deviceInfo[@"Time_appointment_Temp2"] intValue] - [_deviceInfo[@"Tank_temp"] integerValue] )/(1500*0.98) + [_deviceInfo[@"Time_appointment_hour2"] integerValue]*3600 +[_deviceInfo[@"Time_appointment_minute2"] integerValue]*60 ;
        
        _addTimeView.switchView1.text = [NSString stringWithFormat:@"%@到达%@℃",[[NSString TimeStampStandardTimeWithTimeStamp:[NSString stringWithFormat:@"%ld",time- 8*3600]] substringWithRange:NSMakeRange(11, 5)] ,_deviceInfo[@"Time_appointment_Temp2"]];
        //                _promptLable.hidden = NO;
    }else{
        //                _promptLable.hidden = YES;
    }
    
    if ([_deviceInfo[@"Time_appointment_Temp3"] integerValue] > [_deviceInfo[@"Tank_temp"] integerValue]) {
        
        NSInteger time = 4200*100*([_deviceInfo[@"Time_appointment_Temp3"] intValue] - [_deviceInfo[@"Tank_temp"] integerValue] )/(1500*0.98) + [_deviceInfo[@"Time_appointment_hour3"] integerValue]*3600 +[_deviceInfo[@"Time_appointment_minute3"] integerValue]*60 ;
        
        _addTimeView.switchView2.text = [NSString stringWithFormat:@"%@到达%@℃",[[NSString TimeStampStandardTimeWithTimeStamp:[NSString stringWithFormat:@"%ld",time - 8*3600]] substringWithRange:NSMakeRange(11, 5)] ,_deviceInfo[@"Time_appointment_Temp3"]];
        //                _promptLable.hidden = NO;
    }else{
        //                _promptLable.hidden = YES;
    }
    
    if ([_deviceInfo[@"Time_of_appointment1"] integerValue] == 1 ) {
        _addTimeView.switchImageView.hidden = NO;
        _addTimeView.addBtn.hidden = YES;
        _addTimeView.addBtn1.hidden = NO;
    }
    if ([_deviceInfo[@"Time_of_appointment2"] integerValue] == 1) {
        _addTimeView.switchImageView1.hidden = NO;
        _addTimeView.addBtn1.hidden = YES;
        _addTimeView.addBtn2.hidden = NO;
    }
    if ([_deviceInfo[@"Time_of_appointment3"] integerValue] == 1) {
        _addTimeView.switchImageView2.hidden = NO;
//        _addTimeView.addBtn.hidden = YES;
        _addTimeView.addBtn2.hidden = YES;
    }


    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DeviceData" object:nil userInfo:_data];
    NSLog(@"result == %d",result);
    return YES;
}

-(void)onTouchEnd:(CircleSlider *)circleSlider{
    NSLog(@"调用了onTouchEnd()函数");
    [_device write:@{@"entity0":@{@"Temp_electric_heating":@(circleSlider.sliderValue)},@"cmd":@1}];
}

#pragma mark -- slider delegate
-(void)circleSliderValueChanged:(CircleSlider *)circleSlider
{
    NSLog(@"调用了circleSliderValueChanged()函数");
    NSLog(@"当前温度值是：%d",circleSlider.sliderValue);
//
//    [_device write:@{@"entity0":@{@"Temp_electric_heating":@(circleSlider.sliderValue)},@"cmd":@1}];
//    
//    if (_cirleSilder.sliderValue > _cirleSilder.value) {
//        
//        NSInteger time = 4200*100*(_cirleSilder.sliderValue - _cirleSilder.value)/(1500*0.98);
//        
//        //        [[NSString TimeStampStandardTimeWithTimeStamp:[NSString stringWithFormat:@"%f",[[NSString timeToTurnTimeStamp:[NSDate date]] integerValue] + time]] substringWithRange:NSMakeRange(12, 5)]
//        _promptLable.text = [NSString stringWithFormat:@"预计%@到达%d°",[[NSString TimeStampStandardTimeWithTimeStamp:[NSString stringWithFormat:@"%ld",[[NSString timeToTurnTimeStamp:[NSDate date]] integerValue] + time]] substringWithRange:NSMakeRange(11, 5)] ,_cirleSilder.sliderValue];
//        _promptLable.hidden = NO;
//    }else{
//        _promptLable.hidden = YES;
//    }

}

-(void)setStartTime:(NSString *)startTime endTime:(NSString *)endTime temperature:(NSString *)temperature from:(int)from
{
    [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:from inSection:0]].textLabel.text = [NSString stringWithFormat:@"%@ - %@",startTime,endTime];
    [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:from inSection:0]].detailTextLabel.text = temperature;

    NSString *Time1open_hours =[[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:from inSection:0]].textLabel.text substringToIndex:2];
    NSString *Time1open_minutes = [[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:from  inSection:0]].textLabel.text substringWithRange:NSMakeRange(3, 2)];
    NSString *Time1close_hours = [[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:from  inSection:0]].textLabel.text substringWithRange:NSMakeRange(8, 2)];
    NSString *Time1close_minutes = [[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:from inSection:0]].textLabel.text substringWithRange:NSMakeRange(11, 2)];
    NSString * temp = [[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:from inSection:0]].detailTextLabel.text substringToIndex:[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:from inSection:0]].detailTextLabel.text.length -1];
    
    if (from == 1) {
//        @"Time1":@1,
        NSDictionary * dict = @{@"entity0":@{@"Time1close_hours":Time1close_hours,@"Time1close_minutes":Time1close_minutes,@"Time1open_hours":Time1open_hours,@"Time1open_minutes":Time1open_minutes,@"TimeSetTemp1":temp},@"cmd":@1};
        [_device write:dict];
        [_device write:@{@"entity0":@{@"TimeSetTemp1":temp},@"cmd":@1}];
    }else if (from == 2){
//        @"Time2":@1,
        NSDictionary * dict = @{@"entity0":@{@"Time2close_hours":Time1close_hours,@"Time2close_minutes":Time1close_minutes,@"Time2open_hours":Time1open_hours,@"Time2open_minutes":Time1open_minutes,@"TimeSetTemp2":temp},@"cmd":@1};
        [_device write:dict];
        
    }else if (from == 3){
//        @"Time3":@1,
        NSDictionary * dict = @{@"entity0":@{@"Time3close_hours":Time1close_hours,@"Time3close_minutes":Time1close_minutes,@"Time3open_hours":Time1open_hours,@"Time3open_minutes":Time1open_minutes,@"TimeSetTemp3":temp},@"cmd":@1};
        [_device write:dict];
    }
}
//- (void)swithAction:(UISwitch *)sender
//{
//    if (sender.tag != 10) {
//        
//    NSString *Time1open_hours =[[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag -10 inSection:0]].textLabel.text substringToIndex:2];
//    NSString *Time1open_minutes = [[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag -10  inSection:0]].textLabel.text substringWithRange:NSMakeRange(3, 2)];
//    NSString *Time1close_hours = [[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag -10  inSection:0]].textLabel.text substringWithRange:NSMakeRange(8, 2)];
//    NSString *Time1close_minutes = [[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag -10 inSection:0]].textLabel.text substringWithRange:NSMakeRange(11, 2)];
//        NSString * temp = [[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag -10 inSection:0]].detailTextLabel.text substringToIndex:[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag -10 inSection:0]].detailTextLabel.text.length -1];
//        
//    if (sender.tag == 11) {
//        NSDictionary * dict = @{@"entity0":@{@"Time1":sender.on ? @1 :@0},@"cmd":@1};
////        ,@"Time1close_hours":Time1close_hours,@"Time1close_minutes":Time1close_minutes,@"Time1open_hours":Time1open_hours,@"Time1open_minutes":Time1open_minutes,@"TimeSetTemp1":temp
//        [_device write:dict];
//    }else if (sender.tag == 12){
//        NSDictionary * dict = @{@"entity0":@{@"Time2":sender.on ? @1 :@0},@"cmd":@1};
////,@"Time1close_hours":Time1close_hours,@"Time1close_minutes":Time1close_minutes,@"Time1open_hours":Time1open_hours,@"Time1open_minutes":Time1open_minutes,@"TimeSetTemp2":temp
//        [_device write:dict];
//
//    }else if (sender.tag == 13){
//        NSDictionary * dict = @{@"entity0":@{@"Time3":sender.on ? @1 :@0},@"cmd":@1};
////        ,@"Time1close_hours":Time1close_hours,@"Time1close_minutes":Time1close_minutes,@"Time1open_hours":Time1open_hours,@"Time1open_minutes":Time1open_minutes,@"TimeSetTemp3":temp
//        [_device write:dict];
//    }
//    }else if (sender.tag == 10){
//        if (sender.on == NO) {
//            
//        }
//    }
//}




@end
