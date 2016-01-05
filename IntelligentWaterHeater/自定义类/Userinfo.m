//
//  Userinfo.m
//  TianHe
//
//  Created by 段浩 on 15-1-16.
//  Copyright (c) 2015年 段浩. All rights reserved.
//

#import "Userinfo.h"

#define  kUserInfo @"kUserInfo"
#define kUid @"uid" //用户名
#define kToken @"token" //用户ID
@implementation Userinfo

- (void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:self.uid forKey:kUid];
    [coder encodeObject:self.token forKey:kToken];
}

- (id)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    self.uid= [decoder decodeObjectForKey:kUid];
    self.token = [decoder decodeObjectForKey:kToken];
    return self;
}



- (void)saveUserInfo:(NSDictionary *)dictionary {
    self.uid=dictionary[kUid];
    self.token = dictionary[kToken];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    
    [userDefaults setObject:data forKey:kUserInfo];
    [userDefaults synchronize];
    
}
+ (Userinfo *)currentUser {
    NSData * data = [userDefaults objectForKey:kUserInfo];
    Userinfo *userInfo =  [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return userInfo;
}
@end
