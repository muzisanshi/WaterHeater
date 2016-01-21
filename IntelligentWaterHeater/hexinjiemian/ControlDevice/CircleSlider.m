//
//  CircleSlider.m
//  CircleSlider
//
//  Created by cyl on 15/12/20.
//  Copyright © 2015年 OopsStudio. All rights reserved.
//

#import "CircleSlider.h"

#define degreesToRadians(x) (M_PI*(x)/180.0)

#define COLOR_RGB(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define COLOR_RGB_16(v) [UIColor colorWithRed:((v)>>16)/255.0f green:(((v)>>8)&0xff)/255.0f blue:((v)&0xff)/255.0f alpha:1.0f]


@interface CircleSlider ()<UIGestureRecognizerDelegate> {
  CAShapeLayer *_progressLayer;
  CAGradientLayer *_gradientLayer1;
  CALayer *_gradientLayer;
  
  CGFloat _circleOneRadiu;
  CGFloat _circleTwoRadiu;
  CGFloat _circleThreeRadiu;
  CGFloat _circleLineWidth;

  CGFloat _graduationInnerRadiu;
  CGFloat _graduationOutterRadiu;
  
  CGFloat _highlightGraduationInnerRadiu;
  CGFloat _highlightGraduationOutterRadiu;
  
  UIColor *_highlightGraduationBeginColor;
  UIColor *_highlightGraduationEndColor;
  
  CGFloat _markCircleRadiu;
  CGFloat _markCircleLineWidth;
  CGFloat _markFontSize;
  CGFloat _centerFontSize;
  CGFloat _boxFontSize;
  
  CGFloat _graduationBeginRadians;
  CGFloat _radiansPerGraduation;
  int _countGraduations;
  
  BOOL _isSliding;
}

@end

@implementation CircleSlider


- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  self.isToDraw = YES;
  [self awakeFromNib];
  return self;
}

- (void)awakeFromNib {
    NSLog(@"调用了awakeFromNib()函数");
  _progressLayer = [CAShapeLayer layer];
  _progressLayer.frame = self.bounds;
  _progressLayer.fillColor =  [[UIColor clearColor] CGColor];
  _progressLayer.strokeColor  = [[UIColor blackColor] CGColor];
  _progressLayer.lineCap = kCALineCapSquare;
  _progressLayer.lineWidth = 33;
  _progressLayer.strokeEnd = 0;
  
  CALayer *gradientLayer = [CALayer layer];

  CAGradientLayer *gradientLayer1 =  [CAGradientLayer layer];
  gradientLayer1.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
  [gradientLayer1 setColors:[NSArray arrayWithObjects:
                             (id)[COLOR_RGB(133, 237, 243) CGColor],
                             (id)[COLOR_RGB(220, 207, 74) CGColor],
                             (id)[COLOR_RGB(234, 106, 36) CGColor],
                             nil]];
  [gradientLayer1 setLocations:@[@0.3,@0.49,@0.75,@0.9 ]];
  [gradientLayer1 setStartPoint:CGPointMake(0, 0.5)];
  [gradientLayer1 setEndPoint:CGPointMake(1, 0.5)];
  [gradientLayer addSublayer:gradientLayer1];
  
  _gradientLayer1 = gradientLayer1;
  
  [gradientLayer setMask:_progressLayer];
  [self.layer addSublayer:gradientLayer];
  
  _gradientLayer = gradientLayer;

  _progressLayer.strokeEnd = 1.0f;
  
  
  _isWaterBox = YES;
  _isShowColorfulGraduation = YES;
  
  _graduationBeginRadians = degreesToRadians(150);
  _radiansPerGraduation = degreesToRadians(4);
  _countGraduations = 60;
  
  _highlightGraduationBeginColor = COLOR_RGB(133, 237, 243);
  _highlightGraduationEndColor = COLOR_RGB(234, 106, 36);

  _sliderValue = 20;
  _value = 45;
}

- (void)setSliderValue:(int)sliderValue {
    NSLog(@"调用了setSliderValue()函数");
  if (sliderValue < 20) {
    _sliderValue = 20;
  } else if (sliderValue > 80) {
    _sliderValue = 80;
  } else {
    _sliderValue = sliderValue;
  }
  [self setNeedsDisplay];
  
}

- (void)setValue:(int)value {
  _value = value;
  [self setNeedsDisplay];
}

- (void)setIsWaterBox:(BOOL)isWaterBox {
  _isWaterBox = isWaterBox;
  [self setNeedsDisplay];
}

- (void)setIsShowColorfulGraduation:(BOOL)isShowColorfulGraduation {
  _isShowColorfulGraduation = isShowColorfulGraduation;
  [self setNeedsDisplay];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  CGSize size = self.bounds.size;
  
  CGFloat fitWidth = MIN(size.width, size.height);
  
  _markCircleRadiu = 20;
  _markCircleLineWidth = 3.0f;
  _markFontSize = 17.0f / 25.0f * _markCircleRadiu;
  
  _circleOneRadiu = (fitWidth - _markCircleRadiu * 2) / 2.0f - 10;
  _circleTwoRadiu = _circleOneRadiu - 40;
  _circleThreeRadiu = _circleTwoRadiu - 25;
  _circleLineWidth = 3.0f;
  
  _centerFontSize = _circleThreeRadiu / 2.0f;
  _boxFontSize = (_circleOneRadiu - _circleTwoRadiu) / 2.0f;
  
  _graduationInnerRadiu = _circleTwoRadiu + 13;
  _graduationOutterRadiu = _circleOneRadiu - 13;
  _highlightGraduationInnerRadiu = _graduationInnerRadiu - 2;
  _highlightGraduationOutterRadiu = _graduationOutterRadiu + 2;
  
  CGPoint center = CGPointMake(self.bounds.size.width / 2.0f, self.bounds.size.height / 2.0f);
  
  CGFloat radiu = (_circleTwoRadiu + _circleThreeRadiu) / 2.0f;
  UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radiu, radiu) radius:radiu startAngle:degreesToRadians(-210) endAngle:degreesToRadians(30) clockwise:YES];


  _progressLayer.lineWidth = _circleTwoRadiu - _circleThreeRadiu - _circleLineWidth;
  _progressLayer.frame = [self rectWithCenter:center radiu:radiu];

  radiu = (_circleTwoRadiu + _circleTwoRadiu) / 2.0f;
  _progressLayer.path = [path CGPath];
  _gradientLayer1.frame = CGRectMake(center.x - radiu, center.y - radiu, radiu*2, radiu * 2);

}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    NSLog(@"调用了drawRect函数");
  //℃
  //°
  CGPoint center = CGPointMake(self.bounds.size.width / 2.0f, self.bounds.size.height / 2.0f);

  
  UIColor *bgGrayColor = [UIColor colorWithWhite:239.0f/255.0f alpha:1.0f];
  UIColor *strokeColor = [UIColor colorWithWhite:211.0f/255.0f alpha:1.0f];
  UIColor *fillColor = COLOR_RGB(234, 106, 36);
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
  CGContextSetLineWidth(context, _circleLineWidth);
  CGContextSetFillColorWithColor(context, bgGrayColor.CGColor);
  

  CGContextAddEllipseInRect(context, [self rectWithCenter:center radiu:_circleOneRadiu]);
  CGContextDrawPath(context, kCGPathFillStroke);
  

  CGContextAddEllipseInRect(context, [self rectWithCenter:center radiu:_circleOneRadiu]);
  
  CGContextDrawPath(context, kCGPathFillStroke);
  
  CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
  CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
  
  CGContextAddEllipseInRect(context, [self rectWithCenter:center radiu:_circleTwoRadiu]);
  CGContextDrawPath(context, kCGPathFillStroke);
  

  CGContextSetFillColorWithColor(context, bgGrayColor.CGColor);
  CGContextAddEllipseInRect(context, [self rectWithCenter:center radiu:_circleThreeRadiu]);
  CGContextDrawPath(context, kCGPathFillStroke);

  if (_isShowColorfulGraduation) {
    CGContextSetStrokeColorWithColor(context, COLOR_RGB(160, 227, 190).CGColor);
    
    CGFloat br, bg, bb;
    CGFloat er, eg, eb;
    [_highlightGraduationBeginColor getRed:&br green:&bg blue:&bb alpha:NULL];
    [_highlightGraduationEndColor getRed:&er green:&eg blue:&eb alpha:NULL];
    
    for (int i = 20; i <= _sliderValue; ++i) {
      CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:br + (i - 20) * (er - br)/(_countGraduations +1)
                                                                green:bg + (i - 20) * (eg - bg)/(_countGraduations +1)
                                                                 blue:bb + (i - 20) * (eb - bb)/(_countGraduations +1)
                                                                alpha:1.0f].CGColor);
      CGFloat fc = cosf(_graduationBeginRadians + (i - 20) * _radiansPerGraduation);
      CGFloat fs = sinf(_graduationBeginRadians + (i - 20) * _radiansPerGraduation);
      CGPoint innerPoint = CGPointMake(_highlightGraduationInnerRadiu * fc + center.x, _highlightGraduationInnerRadiu * fs + center.y);
      CGPoint outterPoint = CGPointMake(_highlightGraduationOutterRadiu * fc + center.x, _highlightGraduationOutterRadiu * fs + center.y);
      
      CGContextMoveToPoint(context, innerPoint.x, innerPoint.y);
      CGContextAddLineToPoint(context, outterPoint.x, outterPoint.y);
      CGContextDrawPath(context, kCGPathStroke);
    }
//    CGContextDrawPath(context, kCGPathStroke);
    
    
    
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    for (int i = _sliderValue + 1; i <= _countGraduations + 20; ++i) {
      CGFloat fc = cosf(_graduationBeginRadians + (i - 20) * _radiansPerGraduation);
      CGFloat fs = sinf(_graduationBeginRadians + (i - 20) * _radiansPerGraduation);
      CGPoint innerPoint = CGPointMake(_graduationInnerRadiu * fc + center.x, _graduationInnerRadiu * fs + center.y);
      CGPoint outterPoint = CGPointMake(_graduationOutterRadiu * fc + center.x, _graduationOutterRadiu * fs + center.y);
      
      CGContextMoveToPoint(context, innerPoint.x, innerPoint.y);
      CGContextAddLineToPoint(context, outterPoint.x, outterPoint.y);
      
    }
    
    CGContextDrawPath(context, kCGPathStroke);
    
  } else {
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    for (int i = 20; i <= _countGraduations + 20; ++i) {
      CGFloat fc = cosf(_graduationBeginRadians + (i - 20) * _radiansPerGraduation);
      CGFloat fs = sinf(_graduationBeginRadians + (i - 20) * _radiansPerGraduation);
      CGPoint innerPoint = CGPointMake(_graduationInnerRadiu * fc + center.x, _graduationInnerRadiu * fs + center.y);
      CGPoint outterPoint = CGPointMake(_graduationOutterRadiu * fc + center.x, _graduationOutterRadiu * fs + center.y);
      
      CGContextMoveToPoint(context, innerPoint.x, innerPoint.y);
      CGContextAddLineToPoint(context, outterPoint.x, outterPoint.y);
      
    }
    
    CGContextDrawPath(context, kCGPathStroke);
    
    
    CGContextSetStrokeColorWithColor(context, fillColor.CGColor);
    
    for (int i = _sliderValue; i <= _sliderValue; ++i) {
      CGFloat fc = cosf(_graduationBeginRadians + (i - 20) * _radiansPerGraduation);
      CGFloat fs = sinf(_graduationBeginRadians + (i - 20) * _radiansPerGraduation);
      CGPoint innerPoint = CGPointMake(_highlightGraduationInnerRadiu * fc + center.x, _highlightGraduationInnerRadiu * fs + center.y);
      CGPoint outterPoint = CGPointMake(_highlightGraduationOutterRadiu * fc + center.x, _highlightGraduationOutterRadiu * fs + center.y);
      
      CGContextMoveToPoint(context, innerPoint.x, innerPoint.y);
      CGContextAddLineToPoint(context, outterPoint.x, outterPoint.y);
    }
    CGContextDrawPath(context, kCGPathStroke);
    
  }
  
  NSDictionary *attr;
  if (_sliderValue > _value) {
    attr = @{NSForegroundColorAttributeName:[UIColor colorWithWhite:250.0f/255.0f alpha:1.0f], NSFontAttributeName:[UIFont systemFontOfSize:_markFontSize]};
  } else {
    attr = @{NSForegroundColorAttributeName:[UIColor colorWithWhite:100.0f/255.0f alpha:1.0f], NSFontAttributeName:[UIFont systemFontOfSize:_markFontSize]};
  }
  
  // 判断是否要绘制局部内容，包括小圆圈等
  if (self.isToDraw) {
    // 获取小圆圈的坐标
    CGFloat fc = _circleOneRadiu * cosf(_graduationBeginRadians + (_sliderValue - 20) * _radiansPerGraduation);
    CGFloat fs = _circleOneRadiu * sinf(_graduationBeginRadians + (_sliderValue - 20) * _radiansPerGraduation);
    CGPoint markPoint = CGPointMake(fc + center.x, fs + center.y);
    // 获取小圆圈的绘制区域
    CGRect markRect = CGRectMake(markPoint.x - _markCircleRadiu, markPoint.y - _markCircleRadiu, _markCircleRadiu * 2, _markCircleRadiu * 2);
    // 设置小圆圈的背景颜色
    if (_sliderValue > _value) {
        CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
        CGContextSetFillColorWithColor(context, fillColor.CGColor);
        CGContextAddEllipseInRect(context, markRect);
        // 绘制小圆圈
        CGContextDrawPath(context, kCGPathFill);
    } else {
        CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
        CGContextAddEllipseInRect(context, markRect);
        // 绘制小圆圈
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    NSString *markStr = [NSString stringWithFormat:@"%d", _sliderValue];
    CGSize markSize = [markStr sizeWithAttributes:attr];
    markRect = CGRectMake(markPoint.x - markSize.width / 2.0f, markPoint.y - markSize.height / 2.0f, markSize.width, markSize.height);
    // 在小圆圈中绘制文本
    [markStr drawInRect:markRect withAttributes:attr];
    
    // 绘制中间显示温度
    NSString *centerStr = [NSString stringWithFormat:@"%d℃", _value];
    attr = @{NSForegroundColorAttributeName:[UIColor colorWithWhite:149.0f/255.0f alpha:1.0f], NSFontAttributeName:[UIFont systemFontOfSize:_centerFontSize]};
    CGSize centerStrSize = [centerStr sizeWithAttributes:attr];
    CGRect centerStrRect = [self rectWithCenter:center size:centerStrSize];
    [centerStr drawInRect:centerStrRect withAttributes:attr];
    
    // 绘制水箱文本
    NSString *boxStr = @"水箱";
    attr = @{NSForegroundColorAttributeName:[UIColor colorWithWhite:149.0f/255.0f alpha:1.0f], NSFontAttributeName:[UIFont systemFontOfSize:_boxFontSize]};
    CGSize boxStrSize = [boxStr sizeWithAttributes:attr];
    CGRect boxStrRect = [self rectWithCenter:center size:boxStrSize];
    boxStrRect.origin.y = center.y + (_circleOneRadiu + _circleTwoRadiu) / 2.0f - boxStrSize.height / 2.0f;
    
    [boxStr drawInRect:boxStrRect withAttributes:attr];
    NSLog(@"绘制了水箱或者集热器");
      
  }else{
      // 在中间绘制开启按钮
      CGRect centerButRect = [self rectWithCenter:center size:CGSizeMake(100, 100)];
      self.but = [UIImage imageNamed:@""];
      self.butView = [[UIImageView alloc] initWithImage:self.but];
      [self.butView setFrame:centerButRect];
  }
    
}

- (CGRect)rectWithRect:(CGRect)rect increase:(CGFloat)inc {
  return CGRectMake(rect.origin.x - inc / 2.0f, rect.origin.y - inc / 2.0f, rect.size.width + inc, rect.size.height + inc);
}

- (CGRect)rectWithCenter:(CGPoint)center size:(CGSize)size {
  return CGRectMake(center.x - size.width / 2.0f, center.y - size.height / 2.0f, size.width, size.height);
}

- (CGRect)rectWithCenter:(CGPoint)center radiu:(CGFloat)radiu {
  return CGRectMake(center.x - radiu, center.y - radiu, 2 * radiu, 2 * radiu);
}

- (CGFloat)radiansWithSliderValue:(CGFloat)sliderValue {
  CGFloat radians = (sliderValue - 20) * _radiansPerGraduation + _graduationBeginRadians;
  
  return radians;
}

- (CGFloat)sliderValueWithRadians:(CGFloat)radians {
  while (radians < _graduationBeginRadians) {
    radians += M_PI * 2;
  }
  while (radians > M_PI * 2 + _graduationBeginRadians) {
    radians -= M_PI * 2;
  }
  
  int sliderValue = 20 + (radians - _graduationBeginRadians) / _radiansPerGraduation;
  
  return sliderValue;
}

- (CGFloat)radiansWithPoint:(CGPoint)point {
  CGPoint center = CGPointMake(self.bounds.size.width / 2.0f, self.bounds.size.height / 2.0f);
  CGFloat tx = point.x - center.x;
  CGFloat ty = point.y - center.y;
  CGFloat distance = sqrt(pow(tx, 2) + pow(ty, 2));

  if (point.x >= center.x && point.y >= center.y) {
    return acos(tx / distance);
  } else if (point.x <= center.x && point.y >= center.y) {
    return acos(tx / distance);
  } else if (point.x <= center.x && point.y <= center.y) {
    CGFloat ret = acos(tx / distance);
    ret = (M_PI - ret) * 2 + ret;
    return ret;
  } else {
    CGFloat ret = acos(tx / distance);
    ret = M_PI * 2 - ret;
    return ret;
  }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"调用了touchesBegan函数");
  UITouch *touch = [touches anyObject];
  
  
  CGPoint point = [touch locationInView:self];
  
  CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
  CGFloat distance = pow(point.x - center.x, 2) + pow(point.y - center.y, 2);
  if (distance > _circleOneRadiu * _circleOneRadiu || distance < _circleTwoRadiu * _circleTwoRadiu) {
    _isSliding = NO;
    
    return;
  }
  
  CGFloat radians = [self radiansWithPoint:point];
//  CGFloat degrees = radians * 180 / M_PI;
  while (radians < _graduationBeginRadians) {
    radians += M_PI * 2;
  }
  while (radians > M_PI * 2 + _graduationBeginRadians) {
    radians -= M_PI * 2;
  }
  
  if (radians > _graduationBeginRadians - 2 * _radiansPerGraduation
      && radians < _graduationBeginRadians + (_countGraduations + 2) * _radiansPerGraduation) {
    _isSliding = YES;
    
    self.sliderValue = [self sliderValueWithRadians:radians];
    
    if ([_delegate respondsToSelector:@selector(circleSliderValueChanged:)]) {
      [_delegate circleSliderValueChanged:self];
    }
  } else {
    _isSliding = NO;
    
    CGRect rect = [self rectWithCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2 + (_circleOneRadiu + _circleTwoRadiu) / 2) size:CGSizeMake(70, _circleOneRadiu - _circleTwoRadiu)];
    if (CGRectContainsPoint(rect, point)) {
      
      self.isWaterBox = !_isWaterBox;
      if ([_delegate respondsToSelector:@selector(circleSliderBoxChanged:)]) {
        [_delegate circleSliderBoxChanged:self];
      }
    }
  }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"调用了touchesMoved函数");
  if (_isSliding == YES) {
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGFloat radians = [self radiansWithPoint:point];
    
    while (radians < _graduationBeginRadians) {
      radians += M_PI * 2;
    }
    while (radians > M_PI * 2 + _graduationBeginRadians) {
      radians -= M_PI * 2;
    }
    
    if (radians > _graduationBeginRadians - 2 * _radiansPerGraduation
        && radians < _graduationBeginRadians + (_countGraduations + 2) * _radiansPerGraduation) {
      
      self.sliderValue = [self sliderValueWithRadians:radians];
      if ([_delegate respondsToSelector:@selector(circleSliderValueChanged:)]) {
        [_delegate circleSliderValueChanged:self];
      }
    }
  }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"调用了touchesEnded函数");
    // 在这时候返回数据给服务器
    [_delegate onTouchEnd:self];
  _isSliding = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"调用了touchesCancelled函数");
  _isSliding = NO;
}

@end

