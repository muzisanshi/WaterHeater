//
//  UdpOperation.h
//  udp
//
//  Created by apple  on 15/8/8.
//  Copyright (c) 2015年 com.tuohuangzhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "AsyncUdpSocket.h"
@interface UdpOperation : NSObject
@property(nonatomic,strong)AsyncUdpSocket *udpSocket;

// 获取要通过udp发送的数据的长度
-(int)getScfgLenBuf:(char *) buf_out ssid:(char *)ssid_s pass:(char *) pswd_s ip:(char *) ip_s info:(char *) ext_info;

// crc8循环冗余校验
-(char)CRC8:(unsigned char) crc_base crcdata:(unsigned char) data;

// 发送数据
-(void)sendData:(char *)ssid_s pass:(char *) pswd_s ip:(char *) ip_s info:(char *) ext_info;
- (instancetype)initWithIp:(NSString *)ip;
@property (nonatomic, copy ) void (^sendDataBlock)();
@end
