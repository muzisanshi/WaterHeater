//
//  UdpOperation.m
//  udp
//
//  Created by apple  on 15/8/8.
//  Copyright (c) 2015年 com.tuohuangzhe. All rights reserved.
//

#import "UdpOperation.h"
#import <stdio.h>
@interface UdpOperation()
@end
@implementation UdpOperation
- (instancetype)initWithIp:(NSString *)ip
{
    self = [super init];
    if (self) {
//        //    NSDate *nowTime = [NSDate date];
//        
//        NSMutableString *sendString=[NSMutableString stringWithCapacity:100];
//        [sendString appendString:@"123123a"];
//        //开始发送
//        BOOL res = [self.udpSocket sendData:[sendString dataUsingEncoding:NSUTF8StringEncoding]
//                                     toHost:@"255.255.255.255"
//                                       port:6000
//                                withTimeout:-1
//                    
//                                        tag:0];
        _udpSocket=[[AsyncUdpSocket alloc] initIPv4];
        //绑定端口
        NSError *error = nil;
        [_udpSocket bindToPort:6000 error:&error];
        
        //发送广播设置
        [_udpSocket enableBroadcast:YES error:&error];
        
        //加入群里，能接收到群里其他客户端的消息
        [_udpSocket joinMulticastGroup:ip error:&error];
        //启动接收线程
        [_udpSocket receiveWithTimeout:-1 tag:0];

//
    }
    return self;
}
// 获取要通过udp发送的数据的长度
-(int)getScfgLenBuf:(char*) buf_out ssid:(char *)ssid_s pass:(char *) pswd_s ip:(char *) ip_s info:(char *) ext_info{
    
    unsigned char ip_c[4]={0};
    int i;
    if(!ssid_s||!pswd_s||!ip_s||!ext_info)
    {
        return 0;
    }
    if((strlen(ssid_s)+strlen(pswd_s)+strlen(ext_info))>=(128-14))
    {
        return 0;
    }
    if(sscanf(ip_s, "%3s.%3s.%3s.%3s",&ip_c[0],&ip_c[1],&ip_c[2],&ip_c[3])<0)
    {
        return 0;
    }
    memcpy(&buf_out[0],ssid_s,strlen(ssid_s));
    buf_out[strlen(ssid_s)+1]=0x10;
    buf_out[strlen(ssid_s)+2]=0x10;
    memcpy(&buf_out[strlen(ssid_s)+3],pswd_s,strlen(pswd_s));
    buf_out[strlen(ssid_s)+3+strlen(pswd_s)+1]=0x11;
    buf_out[strlen(ssid_s)+3+strlen(pswd_s)+2]=0x11;
    memcpy(&buf_out[strlen(ssid_s)+3+strlen(pswd_s)+3],ext_info,strlen(ext_info));
    buf_out[strlen(ssid_s)+3+strlen(pswd_s)+3+strlen(ext_info)+1]=0x14;
    buf_out[strlen(ssid_s)+3+strlen(pswd_s)+3+strlen(ext_info)+2]=0x14;
    memcpy(&buf_out[strlen(ssid_s)+3+strlen(pswd_s)+3+strlen(ext_info)+3],ip_c,4);
    buf_out[strlen(ssid_s)+3+strlen(pswd_s)+3+strlen(ext_info)+3+4+1]=0x12;
    buf_out[strlen(ssid_s)+3+strlen(pswd_s)+3+strlen(ext_info)+3+4+2]=0x12;
    buf_out[strlen(ssid_s)+3+strlen(pswd_s)+3+strlen(ext_info)+3+4+3]=0x13;
    buf_out[strlen(ssid_s)+3+strlen(pswd_s)+3+strlen(ext_info)+3+4+4]=0x13;
    do{
        int crc;
        for(crc=0,i=0;i<strlen(ssid_s);i++)crc = [self CRC8:crc crcdata:ssid_s[i]];
        buf_out[strlen(ssid_s)]=crc;
        
        for(crc=0,i=0;i<strlen(pswd_s);i++)crc = [self CRC8:crc crcdata:pswd_s[i]];
        buf_out[strlen(ssid_s)+3+strlen(pswd_s)]=crc;
        
        for(crc=0,i=0;i<strlen(ext_info);i++)crc = [self CRC8:crc crcdata:ext_info[i]];
        buf_out[strlen(ssid_s)+3+strlen(pswd_s)+3+strlen(ext_info)]=crc;
        
        for(crc=0,i=0;i<4;i++)crc = [self CRC8:crc crcdata:ip_c[i]];
        buf_out[strlen(ssid_s)+3+strlen(pswd_s)+3+strlen(ext_info)+3+4]=crc;
        
    }while(0);
    
    return (int)(strlen(ssid_s)+3+strlen(pswd_s)+3+strlen(ext_info)+3+4+5);
}

// crc8循环冗余校验
-(char)CRC8:(unsigned char) crc_base crcdata:(unsigned char) data{
    
    int j;
    unsigned char crc=crc_base;
    crc=crc^data;
    for(j=0;j<8;j++)
    {
        if((crc&0x01)!=0)
            crc=(crc>>1)^0x8c;
        else
            crc=crc>>1;
    }
    return crc;
}

// 发送数据
-(void)sendData:(char *)ssid_s pass:(char *) pswd_s ip:(char *) ip_s info:(char *) ext_info{


    unsigned char smartconfig_detail[128+5]={0,9,18,27,0,0};
     char buffer[1024] ;
    for(int i=0;i<1024;i++){
        buffer[i] = i%10;
    }
    int len_detail=0;
    // 再次处理数据
    len_detail = [self getScfgLenBuf:(char *)&smartconfig_detail[5] ssid:ssid_s pass:pswd_s ip:ip_s info:ext_info];
    
    for(int j= 0;j < 5;j++){
    for(int i = 0;i <len_detail +5 ; i++){
            // 初始化发送的数据
            NSData *data = [[NSData alloc] initWithBytes:buffer length:smartconfig_detail[i]+10];

            [_udpSocket sendData:data toHost:@"255.255.255.255" port:6000 withTimeout:10 tag:0];
            
            [NSThread sleepForTimeInterval:0.01];
            NSLog(@"iii == %d",i);
            // 发送数据
        }
//        if (index == 1) {
//            return;
//        }
    [NSThread sleepForTimeInterval:0.01];
    }
//    [_udpSocket sendData:[@"44234fds" dataUsingEncoding:NSUTF8StringEncoding] toHost:@"255.255.255.255" port:6000 withTimeout:10 tag:0];

}
@end
