//
//  AddTimeView.m
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/12/15.
//  Copyright © 2015年 dailinli. All rights reserved.
//

#import "AddTimeView.h"
@interface AddTimeView()
{
    UITapGestureRecognizer * _tap;
    UITapGestureRecognizer * _tap1;
    UITapGestureRecognizer * _tap2;
    UILongPressGestureRecognizer * _longPress;
    UILongPressGestureRecognizer * _longPress1;
    UILongPressGestureRecognizer * _longPress2;

}
@end

@implementation AddTimeView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _switchImageView = [[UIImageView alloc] initWithFrame:CGRectMake((mScreen.width - 220)/2, 5, 220, 50)];
        _switchImageView.layer.cornerRadius  = 25;
        _switchImageView.userInteractionEnabled = YES;
        _switchImageView.backgroundColor = [UIColor colorWithRed:0.573f green:0.573f blue:0.573f alpha:1.00f];
        [self addSubview:_switchImageView];
        
        UILabel * onLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 50)];
        onLabel.textColor = [UIColor whiteColor];
        onLabel.text = @"  ON";
        onLabel.font = [UIFont systemFontOfSize:15];
        [_switchImageView addSubview:onLabel];
        
        UILabel * offLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_switchImageView.frame)-40, 0, 40, 50)];
        offLabel.textColor = [UIColor whiteColor];
        offLabel.text = @"OFF";
        offLabel.font = [UIFont systemFontOfSize:15];
        [_switchImageView addSubview:offLabel];
        
        _switchView = [[UILabel alloc] initWithFrame:CGRectMake(3, 3, 220/4*3, 50-6)];
        _switchView.backgroundColor = [UIColor whiteColor];
        _switchView.font = [UIFont systemFontOfSize:14];
        _switchView.textColor = [UIColor colorWithRed:0.573f green:0.573f blue:0.573f alpha:1.00f];
        _switchView.textAlignment = NSTextAlignmentCenter;
        _switchView.text = @"00:00水温达到20°";
        _switchView.layer.cornerRadius = 22;
        _switchView.layer.masksToBounds = YES;
        _switchView.userInteractionEnabled = YES;
        [_switchImageView addSubview:_switchView];
        
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [_switchView addGestureRecognizer:pan];
        
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        _tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
        _tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2)];

///
        _switchImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake((mScreen.width - 220)/2, 65, 220, 50)];
        _switchImageView1.layer.cornerRadius  = 25;
        _switchImageView1.userInteractionEnabled = YES;
        _switchImageView1.backgroundColor = [UIColor colorWithRed:0.573f green:0.573f blue:0.573f alpha:1.00f];
        //        _switchImageView.hidden = YES;
        [self addSubview:_switchImageView1];
        
        UILabel * onLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 50)];
        onLabel1.textColor = [UIColor whiteColor];
        onLabel1.text = @"  ON";
        onLabel1.font = [UIFont systemFontOfSize:15];
        [_switchImageView1 addSubview:onLabel1];
        
        UILabel * offLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_switchImageView1.frame)-40, 0, 40, 50)];
        offLabel1.textColor = [UIColor whiteColor];
        offLabel1.text = @"OFF";
        offLabel1.font = [UIFont systemFontOfSize:15];
        [_switchImageView1 addSubview:offLabel1];
        
        _switchView1 = [[UILabel alloc] initWithFrame:CGRectMake(3, 3, 220/4*3, 50-6)];
        _switchView1.backgroundColor = [UIColor whiteColor];
        _switchView1.font = [UIFont systemFontOfSize:14];
        _switchView1.textColor = [UIColor colorWithRed:0.573f green:0.573f blue:0.573f alpha:1.00f];
        _switchView1.textAlignment = NSTextAlignmentCenter;
        _switchView1.text = @"00:00水温达到20°";
        _switchView1.layer.cornerRadius = 22;
        _switchView1.layer.masksToBounds = YES;
        _switchView1.userInteractionEnabled = YES;
        [_switchImageView1 addSubview:_switchView1];
        
        UIPanGestureRecognizer * pan1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction1:)];
        [_switchView1 addGestureRecognizer:pan1];
        
        ////
        _switchImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake((mScreen.width - 220)/2, 125, 220, 50)];
        _switchImageView2.layer.cornerRadius  = 25;
        _switchImageView2.userInteractionEnabled = YES;
        _switchImageView2.backgroundColor = [UIColor colorWithRed:0.573f green:0.573f blue:0.573f alpha:1.00f];
        //        _switchImageView.hidden = YES;
        [self addSubview:_switchImageView2];
        
        UILabel * onLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 50)];
        onLabel2.textColor = [UIColor whiteColor];
        onLabel2.text = @"  ON";
        onLabel2.font = [UIFont systemFontOfSize:15];
        [_switchImageView2 addSubview:onLabel2];
        
        UILabel * offLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_switchImageView2.frame)-40, 0, 40, 50)];
        offLabel2.textColor = [UIColor whiteColor];
        offLabel2.text = @"OFF";
        offLabel2.font = [UIFont systemFontOfSize:15];
        [_switchImageView2 addSubview:offLabel2];
        
        _switchView2 = [[UILabel alloc] initWithFrame:CGRectMake(3, 3, 220/4*3, 50-6)];
        _switchView2.backgroundColor = [UIColor whiteColor];
        _switchView2.font = [UIFont systemFontOfSize:14];
        _switchView2.textColor = [UIColor colorWithRed:0.573f green:0.573f blue:0.573f alpha:1.00f];
        _switchView2.textAlignment = NSTextAlignmentCenter;
        _switchView2.text = @"00:00水温达到20°";
        _switchView2.layer.cornerRadius = 22;
        _switchView2.layer.masksToBounds = YES;
        _switchView2.userInteractionEnabled = YES;
        [_switchImageView2 addSubview:_switchView2];
        
        UIPanGestureRecognizer * pan2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction2:)];
        [_switchView2 addGestureRecognizer:pan2];
        
        _switchImageView.hidden = YES;
        _switchImageView1.hidden = YES;
        _switchImageView2.hidden = YES;
        
        _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(mScreen.width/2-20, 5, 50, 50)];
        [_addBtn setImage:[UIImage changeImageSizeImageName:@"add_time1.png" width:147/3 height:125/3] forState:(UIControlStateNormal)];
        [_addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
//        _addBtn.hidden = YES;
        [self addSubview:_addBtn];
        
        _addBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(mScreen.width/2-20, 65, 50, 50)];
        [_addBtn1 setImage:[UIImage changeImageSizeImageName:@"add_time1.png" width:147/3 height:125/3] forState:(UIControlStateNormal)];
        [_addBtn1 addTarget:self action:@selector(addBtnAction1) forControlEvents:(UIControlEventTouchUpInside)];
        _addBtn1.hidden = YES;
        [self addSubview:_addBtn1];

        _addBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(mScreen.width/2-20, 125, 50, 50)];
        [_addBtn2 setImage:[UIImage changeImageSizeImageName:@"add_time1.png" width:147/3 height:125/3] forState:(UIControlStateNormal)];
        [_addBtn2 addTarget:self action:@selector(addBtnAction2) forControlEvents:(UIControlEventTouchUpInside)];
        _addBtn2.hidden = YES;
        [self addSubview:_addBtn2];

        _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress)];
        _longPress.minimumPressDuration = 1.0;
        [_switchView addGestureRecognizer:_longPress];
        
        _longPress1 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress1)];
        _longPress1.minimumPressDuration = 1.0;
        [_switchView1 addGestureRecognizer:_longPress1];
        _longPress2 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress2)];
        _longPress2.minimumPressDuration = 1.0;
        [_switchView2 addGestureRecognizer:_longPress2];
        
        _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(mScreen.width - 50, 10, 40, 40)];
        [_deleteBtn setImage:[UIImage imageNamed:@"delete.png"] forState:(UIControlStateNormal)];
        [_deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:(UIControlEventTouchUpInside)];
        _deleteBtn.hidden = YES;
        [self addSubview:_deleteBtn];
        
        _deleteBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(mScreen.width - 50, 70, 40, 40)];
        [_deleteBtn1 setImage:[UIImage imageNamed:@"delete.png"] forState:(UIControlStateNormal)];
        [_deleteBtn1 addTarget:self action:@selector(deleteAction1) forControlEvents:(UIControlEventTouchUpInside)];
        _deleteBtn1.hidden = YES;
        [self addSubview:_deleteBtn1];

        _deleteBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(mScreen.width - 50, 130, 40, 40)];
        [_deleteBtn2 setImage:[UIImage imageNamed:@"delete.png"] forState:(UIControlStateNormal)];
        [_deleteBtn2 addTarget:self action:@selector(deleteAction2) forControlEvents:(UIControlEventTouchUpInside)];
        _deleteBtn2.hidden = YES;
        [self addSubview:_deleteBtn2];


    }
    return self;
}
- (void)panAction:(UIPanGestureRecognizer *)pan
{
    if ([pan isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer * panGestureRecongnizer = (UIPanGestureRecognizer *)pan;
        //用来保存视图最初的中心位置
        static CGPoint centerPoint;
        CGPoint translation = [panGestureRecongnizer translationInView:_switchView];
        if (panGestureRecongnizer.state == UIGestureRecognizerStateBegan) {
            centerPoint = _switchView.center;
        }
        else if (panGestureRecongnizer.state == UIGestureRecognizerStateChanged){
            NSLog(@"%f",CGRectGetMaxX(_switchView.frame) - 220 +3 );
            if (CGRectGetMaxX(_switchView.frame) > 220-3) {
                
                return;
            }
            if (_switchView.frame.origin.x < 3) {
                return;
            }
            //            if (CGRectGetMinX(_switchView.frame) >=3 && CGRectGetMaxX(_switchView.frame)<=3) {
            //                _switchView.center = CGPointMake(centerPoint.x+translation.x, centerPoint.y);
            //
            //            }
            _switchView.center = CGPointMake(centerPoint.x+translation.x, centerPoint.y);
            _deleteBtn.hidden = YES;
        }
        else if (panGestureRecongnizer.state == UIGestureRecognizerStateEnded  ){
            centerPoint = _switchView.center;
            if (_switchView.frame.origin.x <= (220.0/5.0)/2) {
                //                return;
                [UIView animateWithDuration:0.1 animations:^{
                    //                    _switchView.center = CGPointMake(mScreen.width+60, _switchView.center.y);
                    _switchView.frame = CGRectMake(3, 3, 220/5*4, 50-6);
                    _switchImageView.backgroundColor = [UIColor colorWithRed:0.573f green:0.573f blue:0.573f alpha:1.00f];
                    
                }];
                if (self.cancelBlock) {
                    self.cancelBlock();
                }
                [_switchView removeGestureRecognizer:_tap];
            }
            if (CGRectGetMaxX(_switchView.frame) >= 220/5*4 + 220.0/5.0/2) {
                [UIView animateWithDuration:0.1 animations:^{
                    //                    _switchView.center = CGPointMake(mScreen.width+60, _switchView.center.y);
                    _switchView.frame = CGRectMake(220/5-3, 3, 220/5*4, 50-6);
                    _switchImageView.backgroundColor = [UIColor colorWithRed:0.082f green:0.576f blue:0.620f alpha:1.00f];
                    
                }];
                if (self.setTemBlock) {
                    self.setTemBlock();
                }
                [_switchView addGestureRecognizer:_tap];
                
            }
        }
    }
    
}

- (void)panAction1:(UIPanGestureRecognizer *)pan
{
    if ([pan isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer * panGestureRecongnizer = (UIPanGestureRecognizer *)pan;
        //用来保存视图最初的中心位置
        static CGPoint centerPoint;
        CGPoint translation = [panGestureRecongnizer translationInView:_switchView1];
        if (panGestureRecongnizer.state == UIGestureRecognizerStateBegan) {
            centerPoint = _switchView1.center;
        }
        else if (panGestureRecongnizer.state == UIGestureRecognizerStateChanged){
            NSLog(@"%f",CGRectGetMaxX(_switchView1.frame) - 220 +3 );
            if (CGRectGetMaxX(_switchView1.frame) > 220-3) {
                
                return;
            }
            if (_switchView1.frame.origin.x < 3) {
                return;
            }
            //            if (CGRectGetMinX(_switchView.frame) >=3 && CGRectGetMaxX(_switchView.frame)<=3) {
            //                _switchView.center = CGPointMake(centerPoint.x+translation.x, centerPoint.y);
            //
            //            }
            _switchView1.center = CGPointMake(centerPoint.x+translation.x, centerPoint.y);
            _deleteBtn1.hidden = YES;

        }
        else if (panGestureRecongnizer.state == UIGestureRecognizerStateEnded  ){
            centerPoint = _switchView1.center;
            if (_switchView1.frame.origin.x <= (220.0/5.0)/2) {
                //                return;
                [UIView animateWithDuration:0.1 animations:^{
                    //                    _switchView.center = CGPointMake(mScreen.width+60, _switchView.center.y);
                    _switchView1.frame = CGRectMake(3, 3, 220/5*4, 50-6);
                    _switchImageView1.backgroundColor = [UIColor colorWithRed:0.573f green:0.573f blue:0.573f alpha:1.00f];
                }];
                if (self.cancelBlock1) {
                    self.cancelBlock1();
                }
                [_switchView1 removeGestureRecognizer:_tap1];
            }
            if (CGRectGetMaxX(_switchView1.frame) >= 220/5*4 + 220.0/5.0/2) {
                [UIView animateWithDuration:0.1 animations:^{
                    //                    _switchView.center = CGPointMake(mScreen.width+60, _switchView.center.y);
                    _switchView1.frame = CGRectMake(220/5-3, 3, 220/5*4, 50-6);
                    _switchImageView1.backgroundColor = [UIColor colorWithRed:0.082f green:0.576f blue:0.620f alpha:1.00f];
                }];
                if (self.setTemBlock1) {
                    self.setTemBlock1();
                }
                [_switchView1 addGestureRecognizer:_tap1];
                
            }
        }
    }
    
}

- (void)panAction2:(UIPanGestureRecognizer *)pan
{
    if ([pan isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer * panGestureRecongnizer = (UIPanGestureRecognizer *)pan;
        //用来保存视图最初的中心位置
        static CGPoint centerPoint;
        CGPoint translation = [panGestureRecongnizer translationInView:_switchView2];
        if (panGestureRecongnizer.state == UIGestureRecognizerStateBegan) {
            centerPoint = _switchView2.center;
        }
        else if (panGestureRecongnizer.state == UIGestureRecognizerStateChanged){
            NSLog(@"%f",CGRectGetMaxX(_switchView2.frame) - 220 +3 );
            if (CGRectGetMaxX(_switchView2.frame) > 220-3) {
                
                return;
            }
            if (_switchView2.frame.origin.x < 3) {
                return;
            }
            //            if (CGRectGetMinX(_switchView.frame) >=3 && CGRectGetMaxX(_switchView.frame)<=3) {
            //                _switchView.center = CGPointMake(centerPoint.x+translation.x, centerPoint.y);
            //
            //            }
            _switchView2.center = CGPointMake(centerPoint.x+translation.x, centerPoint.y);
            _deleteBtn2.hidden = YES;

        }
        else if (panGestureRecongnizer.state == UIGestureRecognizerStateEnded  ){
            centerPoint = _switchView2.center;
            if (_switchView2.frame.origin.x <= (220.0/5.0)/2) {
                //                return;
                [UIView animateWithDuration:0.1 animations:^{
                    //                    _switchView.center = CGPointMake(mScreen.width+60, _switchView.center.y);
                    _switchView2.frame = CGRectMake(3, 3, 220/5*4, 50-6);
                    _switchImageView2.backgroundColor = [UIColor colorWithRed:0.573f green:0.573f blue:0.573f alpha:1.00f];
                }];
                if (self.cancelBlock2) {
                    self.cancelBlock2();
                }
                [_switchView2 removeGestureRecognizer:_tap2];

            }
            if (CGRectGetMaxX(_switchView2.frame) >= 220/5*4 + 220.0/5.0/2) {
                [UIView animateWithDuration:0.1 animations:^{
                    //                    _switchView.center = CGPointMake(mScreen.width+60, _switchView.center.y);
                    _switchView2.frame = CGRectMake(220/5-3, 3, 220/5*4, 50-6);
                    _switchImageView2.backgroundColor = [UIColor colorWithRed:0.082f green:0.576f blue:0.620f alpha:1.00f];
                }];
                if (self.setTemBlock2) {
                    self.setTemBlock2();
                }
                [_switchView2 addGestureRecognizer:_tap2];;
                
            }
        }
    }
}

- (void)tap
{
    if (self.tapBlock) {
        self.tapBlock();
    }
}

- (void)tap1
{
    if (self.tapBlock1) {
        self.tapBlock1();
    }

}

- (void)tap2
{
    if (self.tapBlock2) {
        self.tapBlock2();
    }
}

- (void)addBtnAction
{
    if (self.addBlock) {
        self.addBlock();
    }
}
- (void)addBtnAction1
{
    if (self.addBlock1) {
        self.addBlock1();
    }
}
- (void)addBtnAction2
{
    if (self.addBlock2) {
        self.addBlock2();
    }
}
- (void)longPress
{
    _deleteBtn.hidden = NO;
}
- (void)longPress1
{
    _deleteBtn1.hidden = NO;
}
- (void)longPress2
{
    _deleteBtn2.hidden = NO;
}

- (void)deleteAction
{
    if (self.longBlock) {
        self.longBlock();
    }
    
}
- (void)deleteAction1
{
    if (self.longBlock1) {
        self.longBlock1();
    }

}
- (void)deleteAction2
{
    if (self.longBlock2) {
        self.longBlock2();
    }

}

@end
