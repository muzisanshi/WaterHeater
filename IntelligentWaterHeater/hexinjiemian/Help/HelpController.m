//
//  HelpController.m
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/8/1.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import "HelpController.h"

@interface HelpController ()
@end

@implementation HelpController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"帮助";
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, mScreen.width, mScreen.height-64)];
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    [scrollView setContentSize:(CGSizeMake(mScreen.width*8, mScreen.height - 64))];
    [self.view addSubview:scrollView];
    
    NSArray * images = @[@"link1.jpg",@"link2.jpg",@"link3.jpg",@"link4.jpg",@"link5.jpg",@"link6.jpg",@"link7.jpg",@"link8.jpg"];
    for (int i = 0; i < 8; i ++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(mScreen.width*i, 0, mScreen.width, mScreen.height - 63)];
        imageView.image = [UIImage imageNamed:images[i]];
        [scrollView addSubview:imageView];
    }
}



@end
