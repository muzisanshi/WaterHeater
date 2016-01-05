//
//  LocalSetController.m
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/8/7.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import "LocalSetController.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@interface LocalSetController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * ssid;
}
@property (nonatomic, strong)UITableView * tableView;
@end

@implementation LocalSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"WIFI列表";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    NSLog(@"%@",[self fetchSSIDInfo]);
    ssid = @[[self fetchSSIDInfo]];
    [_tableView reloadData];
}
//-(id)fetchSSIDInfo
//{
//    NSArray *ifs = (__bridge id)CNCopySupportedInterfaces();
//    NSLog(@"%s: Supported interfaces: %@", __func__, ifs);
//    id info = nil;
//    for (NSString *ifnam in ifs) {
//        info = (__bridge id)CNCopyCurrentNetworkInfo((CFStringRef)CFBridgingRetain(ifnam));
////        if (info && [info count]) {
////            break;
////        }
//        NSLog(@"%@",info);
//    }
//    return info ;
//}

- (id)fetchSSIDInfo {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSLog(@"Supported interfaces: %@", ifs);
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSLog(@"%@ => %@", ifnam, info);
        if (info && [info count]) { break; }
    }
    return info;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mScreen.width, mScreen.height - 64) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ssid.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"CellWIFi";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
    }
    cell.textLabel.text = ssid[indexPath.row][@"SSID"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [ _delegate SSID:ssid[indexPath.row][@"SSID"]];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
