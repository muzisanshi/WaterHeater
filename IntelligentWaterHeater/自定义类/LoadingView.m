//
//  LoadingView.m
//  WuZi
//
//  Created by SevenTC on 15/3/18.
//  Copyright (c) 2015年 chenfeng. All rights reserved.
//

#import "LoadingView.h"
@interface LoadingView()

@end
@implementation LoadingView

-(instancetype)initWithMessage:(NSString *)message
{
    self = [super initWithFrame:CGRectMake(0, 0, mScreen.width, mScreen.height-64)];
    if (self) {
        UIView * view = [[UIView alloc]initWithFrame: CGRectMake((mScreen.width-200)/2, (mScreen.height-64 - 100)/2, 200, 50)];
        view.center = CGPointMake(mScreen.width/2, mScreen.height/2-64);
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 10;
        [self addSubview:view];
        UIActivityIndicatorView * load = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 8, 100, 37.5)];
        [load setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
         [load startAnimating];
        [view addSubview:load];
        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.4];
//        UIImageView * imageView1 =  [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 127, 37.5)];
//        imageView1.center = CGPointMake(mScreen.width /2, mScreen.height/2 -20-19-64);
//        imageView1.image = [UIImage imageNamed:@"logo.png"];
////        [self addSubview:imageView1];
//        
//
//        UIImageView * imageView = [[UIImageView alloc]init];
//        imageView.frame = CGRectMake(CGRectGetMinX(imageView1.frame), mScreen.height/2-64 , 20, 20);
////        imageView.center = CGPointMake(self.center.x-30, self.center.y-20);
//        imageView.frame = CGRectMake(30, 15 , 20, 20);
//
//        [view addSubview:imageView];
//        
//        NSMutableArray * imageArray = [[NSMutableArray alloc]init];
//        for (int i =1; i<=12; i ++) {
//            NSString * path = [[NSBundle mainBundle]pathForAuxiliaryExecutable:[NSString stringWithFormat:@"%da.png",i]];
//            UIImage * image = [UIImage imageWithContentsOfFile:path];
//            [imageArray addObject:image];
//        }
//        [imageView setAnimationDuration:8*0.15];
//        [imageView setAnimationImages:imageArray];
//        [imageView startAnimating];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(load.frame)+40, mScreen.height/2 -64, 100, 20)];
        //        label.text = message;
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor grayColor];
        label.text = @"数据加载中...";
        label.frame = CGRectMake(70, 15, 100, 20);
        label.font = [UIFont systemFontOfSize:18];
        [view addSubview:label];

    }
    return self;
}



- (void)cancelLoading
{
    [self removeFromSuperview];
}
//- (void)setFrame:(CGRect)frame
//{
//    frame = CGRectMake(0, 0, mainScreenSize.width, mainScreenSize.height-64);
//    [super setFrame:frame];
//}
@end
