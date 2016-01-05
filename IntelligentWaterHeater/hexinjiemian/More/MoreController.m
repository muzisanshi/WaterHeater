//
//  MoreController.m
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/8/5.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import "MoreController.h"
#import "SetNumberController.h"
@interface MoreController ()<UITableViewDataSource,UITableViewDelegate,SetNumberDelegate>
{
    NSArray * _titles;
    int _from;
    NSString * _temperature;
}
@property (nonatomic, strong)UITableView * tableView;

@end

@implementation MoreController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

//    if (_from == 2) {
//        //        High_pro_temp
//        [_device write:@{@"entity0":@{@"High_pro_temp":_temperature},@"cmd":@1}];
//        _from = 0;
//    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"更多设置";
//     _device.delegate = self;
//    [_device login:[Userinfo currentUser].uid token:[Userinfo currentUser].token];
//    _titles = @[@"童锁功能开关",@"加热开关",@"高温保护温度",@"低温保护温度",@"电磁阀启动温度",@"电池阀关闭温度",@"集热器温度",@"水箱温度"];
    _titles = @[@"童锁功能开关",@"设备模式"];
    _from = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DeviceData:) name:@"DeviceData" object:nil];
    
    [self.view addSubview:self.tableView];
}
- (BOOL)XPGWifiDevice:(XPGWifiDevice *)device didReceiveData:(NSDictionary *)data result:(int)result;
{
    NSLog(@"data == %@",data);
    return YES;
}
- (void)DeviceData:(NSNotification *)notice
{
    [((UISwitch *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].accessoryView) setOn: [[notice userInfo][@"entity0"][@"Tong_Suo"] integerValue]  == 1 ?YES:NO animated:YES];
    if ([[notice userInfo][@"entity0"][@"Working_mode"] integerValue] == 0) {
        ((UILabel *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]].accessoryView).text = @"常规";
    }else if ([[notice userInfo][@"entity0"][@"Working_mode"] integerValue] == 1){
        ((UILabel *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]].accessoryView).text = @"经济";
    }else if ([[notice userInfo][@"entity0"][@"Working_mode"] integerValue] == 2){
        ((UILabel *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]].accessoryView).text = @"舒适";
    }else if ([[notice userInfo][@"entity0"][@"Working_mode"] integerValue] == 3){
        ((UILabel *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]].accessoryView).text = @"全天候";
    }else if ([[notice userInfo][@"entity0"][@"Working_mode"] integerValue] == 4){
        ((UILabel *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]].accessoryView).text = @"个性";
    }



//    [((UISwitch *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]].accessoryView) setOn: [[notice userInfo][@"entity0"][@"Heating_state"] integerValue]  == 1 ?YES:NO animated:YES];
//    
//    [((UILabel *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]].accessoryView) setText:[NSString stringWithFormat:@"%@ °",[notice userInfo][@"entity0"][@"High_pro_temp"]]] ;
//    [((UILabel *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]].accessoryView) setText:[NSString stringWithFormat:@"%@ °",[notice userInfo][@"entity0"][@"Low_pro_temp"]]];
//    [((UILabel *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]].accessoryView) setText:[NSString stringWithFormat:@"%@ °",[notice userInfo][@"entity0"][@"Solenoid_start_temp"]]];
//    [((UILabel *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]].accessoryView) setText:[NSString stringWithFormat:@"%@ °",[notice userInfo][@"entity0"][@"Solenoid_close_temp"]]];
//    [((UILabel *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]].accessoryView) setText:[NSString stringWithFormat:@"%@ °",[notice userInfo][@"entity0"][@"Collector_temp"]]];
//    [((UILabel *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]].accessoryView) setText:[NSString stringWithFormat:@"%@ °",[notice userInfo][@"entity0"][@"Tank_temp"]]];
    



}

- (void)XPGWifiDevice:(XPGWifiDevice *)device didLogin:(int)result;
{
    NSLog(@"device login11 == %d",result);
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mScreen.width, mScreen.height - 64) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"helpCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
        [cell setAccessoryType:1];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        if (indexPath.row <1) {
            UISwitch * swicht = [[UISwitch alloc]init];
            swicht.tag = 100+indexPath.row;
            [swicht addTarget:self action:@selector(switchAction:) forControlEvents:(UIControlEventTouchUpInside)];
            cell.accessoryView = swicht;
            if (indexPath.row == 1) {
                swicht.userInteractionEnabled = NO;
            }
        }else{
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
            label.text = @"常规";
            label.textAlignment = NSTextAlignmentRight;
            label.tag = 100 +indexPath.row;
            cell.accessoryView = label;
        }
    }
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        SetNumberController * numberVC= [[SetNumberController alloc]init];
        numberVC.delegate = self;
        numberVC.title = @"设置高温保护温度";
        numberVC.warnString = @"高温保护：设置高温温度基数，当温度高于此值时，向用户报警。";
        numberVC.from = (int)indexPath.row;
        [self.navigationController pushViewController:numberVC animated:YES];
    }else if (indexPath.row == 3){
        SetNumberController * numberVC= [[SetNumberController alloc]init];
        numberVC.title = @"设置低温保护温度";
        numberVC.delegate = self;
        numberVC.warnString = @"低温保护：设置低温温度基数，当温度低于此值时，向用户报警。";
        numberVC.from = (int)indexPath.row;
        [self.navigationController pushViewController:numberVC animated:YES];

    }else if (indexPath.row == 4){
        SetNumberController * numberVC= [[SetNumberController alloc]init];
        numberVC.title = @"设置电磁阀启动温度";
        numberVC.delegate = self;
        numberVC.from = (int)indexPath.row;
        numberVC.warnString = @"电磁阀启动温度：启动时电磁阀达到的温度，注意，请不要随意修改。";
        [self.navigationController pushViewController:numberVC animated:YES];

    }else if (indexPath.row == 5){
        SetNumberController * numberVC= [[SetNumberController alloc]init];
        numberVC.title = @"设置电磁阀关闭温度";
        numberVC.from = (int)indexPath.row;
        numberVC.delegate = self;
        numberVC.warnString = @"电磁阀关闭温度：关闭时电磁阀达到的温度，注意，请不要随意修改。";
        [self.navigationController pushViewController:numberVC animated:YES];

    }else if (indexPath.row == 6){
        
    }else if (indexPath.row == 7){
        
    }
}
- (void)switchAction:(UISwitch *)sender
{
    if (sender.tag == 100) {
//        [_device write:@{@"entity0":@{@"Tong_Suo":[NSNumber numberWithBool:sender.on] },@"cmd":@1}];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"controlDeivce" object:nil userInfo:@{@"entity0":@{@"Tong_Suo":[NSNumber numberWithBool:sender.on] },@"cmd":@1}];
        
    }else if (sender.tag == 101){
        
    }
}

- (void)setTemperature:(NSString *)temperature from:(int)from
{
    [((UILabel *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:from inSection:0]].accessoryView) setText:temperature];
    _from = from;
    _temperature = [temperature substringToIndex:temperature.length -2];
}
@end
