//
//  AccountManageController.m
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/8/1.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import "AccountManageController.h"
#import "ChangePassController.h"
@interface AccountManageController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong)UITableView * tableView;
@end

@implementation AccountManageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"用户管理";
    [self.view addSubview:self.tableView];
    
    UIButton * logout = [[UIButton alloc]initWithFrame:CGRectMake(30, mScreen.height - 100-64, mScreen.width - 60, 40)];
    logout.backgroundColor = [UIColor redColor];
    [logout setTitle:@"注销" forState:(UIControlStateNormal)];
    [logout setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
    [self.view addSubview:logout];
    [logout addTarget:self action:@selector(logout) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)logout
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
    if (!_tableView ) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mScreen.width , 120) style:(UITableViewStylePlain)];
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return  _tableView;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"CellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(1) reuseIdentifier:cellID];
        if (indexPath.row == 1) {
            cell.accessoryType = 1;
        }
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"用户名";
        cell.detailTextLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    }else if (indexPath.row == 1){
    cell.textLabel.text = @"修改密码";
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        [self.navigationController pushViewController:[[ChangePassController alloc] init] animated:YES];
    }
}
@end
