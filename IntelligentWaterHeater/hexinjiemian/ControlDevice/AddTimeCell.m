//
//  AddTimeCell.m
//  IntelligentWaterHeater
//
//  Created by dailinli on 15/10/21.
//  Copyright © 2015年 dailinli. All rights reserved.
//

#import "AddTimeCell.h"
@interface AddTimeCell()
//{
//    UILabel * _switchView;
//}
@end
@implementation AddTimeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(mScreen.width/2-20, 5, 50, 50)];
        [_addBtn setImage:[UIImage changeImageSizeImageName:@"add_time1.png" width:147/3 height:125/3] forState:(UIControlStateNormal)];
        [_addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        _addBtn.hidden = YES;
        [self.contentView addSubview:_addBtn];
        
        _switchImageView = [[UIImageView alloc] initWithFrame:CGRectMake((mScreen.width - 220)/2, 5, 220, 50)];
        _switchImageView.layer.cornerRadius  = 25;
        _switchImageView.userInteractionEnabled = YES;
        _switchImageView.backgroundColor = [UIColor colorWithRed:0.573f green:0.573f blue:0.573f alpha:1.00f];
        _switchImageView.hidden = YES;
        [self.contentView addSubview:_switchImageView];
        
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

            }
        }
    }

}
- (void)addBtnAction
{
    if (self.addBlock) {
        self.addBlock();
    }
}
@end
