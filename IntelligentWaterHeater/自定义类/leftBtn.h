//
//  leftBtn.h
//  WuZi
//
//  Created by SevenTC on 15/3/16.
//  Copyright (c) 2015年 chenfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface leftBtn : UIButton
@property (nonatomic, copy) void (^popAction)();
@end
