//
//  SetTimeTemperatureController.m
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/8/5.
//  Copyright (c) 2015年 dailinli. All rights reserved.
//

#import "SetTimeTemperatureController.h"
#import "EFCircularSlider.h"
#import "CircleSlider.h"

@interface SetTimeTemperatureController ()
{
    UIDatePicker * startTime;
    UIDatePicker * endTime;
    UIScrollView * scr ;
    UIView * temperuterView;
    int temperuaterValue;
    
}
@end

@implementation SetTimeTemperatureController

- (void)viewDidLoad {
    NSLog(@"SetTimeTemperatureController-------viewDidLoad()");
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor: kRGBA(90, 154, 222, 1)];
    self.title = @"预约设置";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction)];
    UISegmentedControl * seg = [[UISegmentedControl alloc]initWithItems:@[@"时间设置",@"温度设置"]];
    seg.frame = CGRectMake(0, 0, mScreen.width, 40);
    seg.tintColor = [UIColor lightGrayColor];
    seg.backgroundColor =kRGBA(252, 252, 252, 1);
    [seg addTarget:self action:@selector(segAction:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:seg];

    
    scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, mScreen.width, mScreen.height - 104)];
    [self.view addSubview:scr];
    UILabel * startLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, mScreen.width, 20)];
    startLable.text = @"启动时间";
    startLable.textColor = [UIColor whiteColor];
    startLable.userInteractionEnabled = YES;
    [scr addSubview:startLable];
    
    startTime = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(startLable.frame), mScreen.width, 216)];
    [startTime setDatePickerMode:UIDatePickerModeTime];
    [startTime addTarget:self action:@selector(timeAction:) forControlEvents:(UIControlEventValueChanged)];
    [scr addSubview:startTime];
    
    UILabel * endLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(startTime.frame)+10, mScreen.width, 20)];
     endLabel.text = @"关闭时间";
    endLabel.textColor = [UIColor whiteColor];
    endLabel.userInteractionEnabled = YES;
    [scr addSubview:endLabel];
    
    endTime = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(endLabel.frame), mScreen.width, 216)];
    [endTime setDatePickerMode:UIDatePickerModeTime];
    [endTime addTarget:self action:@selector(timeAction:) forControlEvents:(UIControlEventValueChanged)];
    [scr addSubview:endTime];
    
    [scr setContentSize:CGSizeMake(mScreen.width, CGRectGetMaxY(endTime.frame))];

    temperuterView  = [[UIView alloc]initWithFrame:CGRectMake(0, 40, mScreen.width, mScreen.height - 104)];
    
    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(30, 10, mScreen.width - 60, mScreen.width - 60)];
    imageview.center = CGPointMake(temperuterView.frame.size.width/2, temperuterView.frame.size.height/2);
    imageview.userInteractionEnabled = YES;
    imageview.image = [UIImage imageNamed:@"water_heating_setting_round1.png"];
//    [temperuterView addSubview:imageview];
    
    
    
//    CGRect sliderFrame = imageview.frame;
//    EFCircularSlider* circularSlider = [[EFCircularSlider alloc] initWithFrame:sliderFrame];
//    [circularSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
//    circularSlider.filledColor = [UIColor greenColor];
//    circularSlider.handleType = 3;
//    circularSlider.handleColor = [UIColor whiteColor];
//    circularSlider.unfilledColor = [UIColor whiteColor];
    
    CircleSlider *circularSlider = [[CircleSlider alloc] initWithFrame:imageview.frame];
    [temperuterView addSubview:circularSlider];

   
    
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

-(void)valueChanged:(EFCircularSlider*)slider {
    ((UILabel *)[temperuterView viewWithTag:200]).text = [NSString stringWithFormat:@"%d °", (int)slider.currentValue ];
    temperuaterValue =(int)slider.currentValue;
}

- (void)saveAction
{
    [_delegate setStartTime:[[NSString stringWithFormat:@"%@",[[startTime date] dateByAddingTimeInterval:3600 *8]] substringWithRange:NSMakeRange(11, 5)] endTime:[[NSString stringWithFormat:@"%@",[[endTime date] dateByAddingTimeInterval:3600 *8]] substringWithRange:NSMakeRange(11, 5)] temperature:[NSString stringWithFormat: @"%d℃",temperuaterValue]  from:_from];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)segAction:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
          [temperuterView removeFromSuperview];
        [self.view addSubview:scr];
      
    }else{
        
        [scr removeFromSuperview];
//        [self.view addSubview:temperuterView];
    }
}

- (void)timeAction:(UIDatePicker *)sender
{
    if (sender == startTime) {
        
    }
    NSLog(@"%@",[NSString stringWithFormat:@"%@",[[startTime date] dateByAddingTimeInterval:3600 *8]]);
}



@end
