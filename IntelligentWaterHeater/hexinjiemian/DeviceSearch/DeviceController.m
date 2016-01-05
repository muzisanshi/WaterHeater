//
//  DeviceController.m
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/7/29.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import "DeviceController.h"
#import "BoundDeviceController.h"
#import "ControlDeviceController.h"
@interface DeviceController ()<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,XPGWifiSDKDelegate,XPGWifiDeviceDelegate>{
    NSArray * _deviceList;
    NSMutableArray * _onlineDevice;
    NSMutableArray * _offLineDevice;
    NSMutableArray * _noBoundDevice;
}
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation DeviceController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [XPGWifiSDK sharedInstance].delegate = self;
    
    // 下载配置文件
    [XPGWifiSDK updateDeviceFromServer:@"bb0a82c2ce174e989be7941bd1dc691d"];
    NSLog(@"已下载了设备的配置文件");

    [_tableView headerBeginRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"设备搜索";
//    logout_icon
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage changeImageSizeImageName:@"logout_icon.png" width:25 height:25] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftItemAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage changeImageSizeImageName:@"add_icon.png" width:25 height:25] style:(UIBarButtonItemStylePlain) target:self action:@selector(rightItemAction)];

    [self initData];
//    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    

//    [self fresh];
    
    
}
- (void)rightItemAction
{
    [self.navigationController pushViewController:[[BoundDeviceController alloc]init] animated:YES];
}
-(void)initData
{
    _onlineDevice = [[NSMutableArray alloc]init];
    _offLineDevice = [[NSMutableArray alloc]init];
    _noBoundDevice = [[NSMutableArray alloc]init];
}

- (void)XPGWifiSDK:(XPGWifiSDK *)wifiSDK didDiscovered:(NSArray *)deviceList result:(int)result;
{
    NSLog(@"deviceList == %@",deviceList);
    _deviceList = deviceList;
    [_onlineDevice removeAllObjects];
    [_offLineDevice removeAllObjects];
    [_noBoundDevice removeAllObjects];
    if (deviceList.count != 0) {
        for (XPGWifiDevice * device in deviceList) {
            NSLog(@"%@",device.remark);
            NSLog(@"device == %@",device);
            if (device.isOnline) {
                [_onlineDevice addObject:device];
            }else if(!device.isOnline){
                [_offLineDevice addObject:device];
            }
        }
     
    }else{
        
    }
    
       [_tableView reloadData];
    [_tableView headerEndRefreshing];
}
- (void)leftItemAction
{
    [[[UIAlertView alloc] initWithTitle:nil message:@"确定要注销？返回登录界面吗？" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"确定", nil]show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kUserInfo"];
        
        [self.navigationController popToRootViewControllerAnimated:NO ];
    }
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return _onlineDevice.count == 0 ? 1: _onlineDevice.count;
    }else if (section == 1){
        return _offLineDevice.count == 0 ? 1:_offLineDevice.count;
    }else{
        return _noBoundDevice.count == 0 ? 1:_noBoundDevice.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return  @"在线设备";
    }else if (section == 1) {
        return  @"离线设备";
    }else {
        return  @"未绑定设备";
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170/2+20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString * cellID = [NSString stringWithFormat:@"%ld%ld",indexPath.row,indexPath.section];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:1 reuseIdentifier:cellID];
        cell.separatorInset = UIEdgeInsetsMake(0, -5, 0, 5);
    }
    if (indexPath.section == 0) {
        
        cell.textLabel.text =_onlineDevice.count == 0 ? @"没有设备": ((XPGWifiDevice *) _onlineDevice[indexPath.row]).productName;
        if (_onlineDevice.count != 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"远程在线";
            cell.textLabel.textColor = kRGBADefault;
            cell.imageView.image = [UIImage changeImageSizeImageName:@"device_icon_blue.png" width:130/2 height:170/2];
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.detailTextLabel.text = @"";
        }
    }else if (indexPath.section == 1){
        cell.textLabel.text =_offLineDevice.count == 0 ? @"没有设备":((XPGWifiDevice *) _offLineDevice[indexPath.row]).productName;
        cell.textLabel.textColor = [UIColor grayColor];
        cell.imageView.image = [UIImage changeImageSizeImageName:@"device_icon_gray.png" width:130/2 height:170/2];
    }else{
        cell.textLabel.text = @"没有设备";
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && _onlineDevice.count != 0) {
        ControlDeviceController * cdvc = [[ControlDeviceController alloc] init];
        cdvc.title =((XPGWifiDevice *) _onlineDevice[indexPath.row]).productName;
        cdvc.device =_onlineDevice[indexPath.row];
        [self.navigationController pushViewController:cdvc animated:YES];
    }
}
@end
