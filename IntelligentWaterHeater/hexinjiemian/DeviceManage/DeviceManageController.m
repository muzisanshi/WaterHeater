//
//  DeviceManageController.m
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/8/1.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import "DeviceManageController.h"
#import "BoundDeviceController.h"
#import "ChangeDeviceInfoController.h"
@interface DeviceManageController ()<XPGWifiSDKDelegate,XPGWifiDeviceDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray * _deviceList;
}
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation DeviceManageController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [XPGWifiSDK sharedInstance].delegate = self;

    [_tableView headerBeginRefreshing];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的设备";
      [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage changeImageSizeImageName:@"add_icon.png" width:25 height:25] style:(UIBarButtonItemStylePlain) target:self action:@selector(rightItemAction)];
}
- (void)rightItemAction
{
    [self.navigationController pushViewController:[[BoundDeviceController alloc]init] animated:YES];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mScreen.width, mScreen.height - 64) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView addHeaderWithTarget:self action:@selector(fresh)];
        
    }
    return _tableView;
}
- (void)fresh
{
    [[XPGWifiSDK sharedInstance] getBoundDevicesWithUid:[Userinfo currentUser].uid token:[Userinfo currentUser].token specialProductKeys: nil];
    
}
- (void)XPGWifiSDK:(XPGWifiSDK *)wifiSDK didDiscovered:(NSArray *)deviceList result:(int)result;
{
    NSLog(@"deviceList == %@",deviceList);
    _deviceList = deviceList;
//    [_onlineDevice removeAllObjects];
//    [_offLineDevice removeAllObjects];
//    [_noBoundDevice removeAllObjects];
//    if (deviceList.count != 0) {
//        for (XPGWifiDevice * device in deviceList) {
//            NSLog(@"%@",device.remark);
//            NSLog(@"device == %@",device);
//            if (device.isOnline) {
//                [_onlineDevice addObject:device];
//            }else if(!device.isOnline){
//                [_offLineDevice addObject:device];
//            }
//        }
//        
//    }else{
//        
//    }
    
    [_tableView reloadData];
    [_tableView headerEndRefreshing];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _deviceList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 51/1.2+20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellID = [NSString stringWithFormat:@"%ld%ld",indexPath.row,indexPath.section];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:1 reuseIdentifier:cellID];
        cell.separatorInset = UIEdgeInsetsMake(0, -5, 0, 5);
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    }
    if (((XPGWifiDevice *) _deviceList[indexPath.row]).isOnline) {
        cell.textLabel.textColor = kRGBADefault;
        cell.imageView.image = [UIImage changeImageSizeImageName:@"device.png" width:76/1.2 height:51/1.2];

    }else{
        cell.textLabel.textColor = [UIColor grayColor];
        cell.imageView.image = [UIImage changeImageSizeImageName:@"device2.png" width:76/1.2 height:51/1.2];

    }
    cell.textLabel.text = ((XPGWifiDevice *) _deviceList[indexPath.row]).productName;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChangeDeviceInfoController * changeVC =  [[ChangeDeviceInfoController alloc]init];
    changeVC.title = ((XPGWifiDevice *) _deviceList[indexPath.row]).productName;
    changeVC.did = ((XPGWifiDevice *) _deviceList[indexPath.row]).did;
    [self.navigationController pushViewController:changeVC animated: YES];
}
@end
