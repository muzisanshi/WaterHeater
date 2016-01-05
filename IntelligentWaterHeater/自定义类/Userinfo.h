//
//  Userinfo.h
//  TianHe
//
//  Created by 段浩 on 15-1-16.
//  Copyright (c) 2015年 段浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Userinfo : NSObject<NSCoding>

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *token;

- (void)saveUserInfo:(NSDictionary *)dictionary;

+ (Userinfo *)currentUser;


@end
