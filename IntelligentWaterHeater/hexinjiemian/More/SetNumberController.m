//
//  SetNumberController.m
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/8/7.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import "SetNumberController.h"
#import "EFCircularSlider.h"
#import "NSString+TextSize.h"
@interface SetNumberController ()

@end

@implementation SetNumberController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kRGBA(77, 133, 192, 1);
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction)];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, mScreen.width - 40, [NSString getTextHeightWithFont:[UIFont systemFontOfSize:17] forWidth:mScreen.width - 40 text:_warnString])];
    label.textColor = [UIColor redColor];
    label.numberOfLines = 0;
    label.text = _warnString;
    [self.view addSubview:label];
    
    
    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(label.frame )+30, mScreen.width - 60, mScreen.width - 60)];
    imageview.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    imageview.userInteractionEnabled = YES;
    imageview.image = [UIImage imageNamed:@"water_heating_setting_round1.png"];
    [self.view addSubview:imageview];
    
    CGRect sliderFrame = imageview.frame;
    EFCircularSlider* circularSlider = [[EFCircularSlider alloc] initWithFrame:sliderFrame];
    [circularSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    circularSlider.filledColor = [UIColor greenColor];
    //    @"water_heating_setting_round3.png"
    circularSlider.handleType = 3;
    circularSlider.handleColor = [UIColor whiteColor];
    circularSlider.unfilledColor = [UIColor whiteColor];
    __weak EFCircularSlider * efcBlock = circularSlider;
    circularSlider.endSlideBlock = ^{
        NSDictionary * dict;
        
        if (_from == 2) {
            dict = @{@"entity0":@{@"High_pro_temp":[NSNumber numberWithInt:(int)efcBlock.currentValue] },@"cmd":@1};
        }else if (_from == 3){
            dict = @{@"entity0":@{@"Low_pro_temp":[NSNumber numberWithInt:(int)efcBlock.currentValue] },@"cmd":@1};
        }else if (_from == 4){
            dict = @{@"entity0":@{@"Solenoid_start_temp":[NSNumber numberWithInt:(int)efcBlock.currentValue] },@"cmd":@1};
        }else if (_from == 5){
            dict = @{@"entity0":@{@"Solenoid_close_temp":[NSNumber numberWithInt:(int)efcBlock.currentValue] },@"cmd":@1};
        }else if (_from == 6){
            dict = @{@"entity0":@{@"Collector_temp":[NSNumber numberWithInt:(int)efcBlock.currentValue] },@"cmd":@1};
        }else if (_from == 7){
            dict = @{@"entity0":@{@"Tank_temp":[NSNumber numberWithInt:(int)efcBlock.currentValue] },@"cmd":@1};
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"controlDeivce" object:nil userInfo:dict];
        [_delegate setTemperature:((UILabel *)[self.view viewWithTag:200]).text from:_from];

    };
    
    //    UIImageView * filledImage = [[UIImageView alloc]initWithFrame:sliderFrame];
    //    filledImage.image = [UIImage imageNamed:@"water_heating_setting_round3.png"];
    //
    //     [temperuterView addSubview:filledImage];
    [self.view addSubview:circularSlider];
    
    
    
    UILabel * temperature = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, imageview.frame.size.width, 60)];
    temperature.textAlignment = NSTextAlignmentCenter;
    temperature.textColor = [UIColor whiteColor];
    temperature.tag = 200;
    temperature.center = CGPointMake(imageview.frame.size.width/2, imageview.frame.size.height /2);
    temperature.text = [NSString stringWithFormat:@"0 °"];
    temperature.font = [UIFont fontWithName:@"DIN Alternate" size:40];
    [imageview addSubview:temperature];
    
    UILabel * desc = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(temperature.frame) +10, imageview.frame.size.width, 20)];
    desc.textAlignment = NSTextAlignmentCenter;
    desc.textColor = [UIColor whiteColor];
    desc.text = @"温度设置";
    desc.font = [UIFont systemFontOfSize:17];
    [imageview addSubview:desc];

}

- (void)saveAction{
    [_delegate setTemperature:((UILabel *)[self.view viewWithTag:200]).text from:_from];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)valueChanged:(EFCircularSlider*)slider {
    ((UILabel *)[self.view viewWithTag:200]).text = [NSString stringWithFormat:@"%d °", (int)slider.currentValue ];
//    temperuaterValue =(int)slider.currentValue;
}

@end
