//
//  MenuView.m
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/7/31.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import "MenuView.h"
#import "AboutController.h"
#import "AccountManageController.h"
#import "DeviceManageController.h"
#import "HelpController.h"
#import "BoundDeviceController.h"
@interface MenuView()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * _titles;
}
@end
@implementation MenuView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIButton * backItem = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 40, 40)];
        [backItem setImage:[UIImage changeImageSizeImageName:@"icon_back.png" width:20 height:20] forState:(UIControlStateNormal)];
        [backItem addTarget:self action:@selector(backItemAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:backItem];
        
        _titles = @[@"我的设备",@"帮助",@"设置"];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(mScreen.width/5, 20+64, mScreen.width/5*3, 40)];
        titleLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"title_backg.png"]];
        titleLabel.text = [userDefaults objectForKey:@"username"];
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        
        UILabel * currentDeviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(mScreen.width/5, 60+64, mScreen.width/5*3, 40)];
        currentDeviceLabel.text = [NSString stringWithFormat:@"%@使用中",title];
        currentDeviceLabel.textColor = [UIColor grayColor];
        currentDeviceLabel.font = [UIFont systemFontOfSize:14];
        currentDeviceLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:currentDeviceLabel];
        
        
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100+64, mScreen.width, 180) style:(UITableViewStyleGrouped)];
        tableView.delegate = self;
        tableView.scrollEnabled = NO;
        tableView.dataSource = self;
        [self addSubview:tableView];
        
        UILabel * versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(mScreen.width/5, 280+64, mScreen.width/5*3, 40)];
        versionLabel.text = [NSString stringWithFormat:@"当前版本：V1.0"];
        versionLabel.textColor = [UIColor grayColor];
        versionLabel.font = [UIFont systemFontOfSize:15];
        versionLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:versionLabel];
        
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(mScreen.width/5, 320+64, mScreen.width/5*3, mScreen.width/5*3 /(337.0/86.0)) ];
//        btn.backgroundColor = [UIColor redColor];
        [btn setImage:[UIImage imageNamed:@"tian_jia.png"] forState:(UIControlStateNormal)];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(addDevieAction) forControlEvents:(UIControlEventTouchUpInside)];
      
        UIButton * backDeviceList = [[UIButton alloc]initWithFrame:CGRectMake(0, frame.size.height - 60, 150, 50)];
        [backDeviceList setTitle:@"返回设备列表" forState:(UIControlStateNormal)];
        [backDeviceList setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
        [backDeviceList setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
        [backDeviceList addTarget:self action:@selector(backListAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:backDeviceList];
    }
    return self;
}

- (void)backItemAction{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(-mScreen.width, 0, mScreen.width, mScreen.height );
    }];

}
- (void)addDevieAction{
    [[self navigationController] pushViewController:[[BoundDeviceController alloc] init] animated:YES];
}
- (void)backListAction
{
    [[self navigationController] popViewControllerAnimated:YES];
}

//获取视图contr
-(UINavigationController *)navigationController
{
    for (UIView * next = [self superview] ; next; next = next.superview) {
        UIResponder * nextRes = [next nextResponder];
        if ([nextRes isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController*)nextRes;
        }
    }
    return nil;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdent = @"menuCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdent];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    }
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [[self navigationController] pushViewController:[[DeviceManageController alloc] init] animated:YES];
    
    }else if (indexPath.row == 1){
        [[self navigationController] pushViewController:[[HelpController alloc] init] animated:YES];
    }else if (indexPath.row == 2){
        if (self.moreSetBlock) {
            self.moreSetBlock();
        }
    }
        
}
@end
