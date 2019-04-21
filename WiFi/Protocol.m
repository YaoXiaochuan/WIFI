//
//  Protocol.m
//  WiFi
//
//  Created by 李兰芳 on 2019/4/20.
//  Copyright © 2019年 YaoXiaochuan. All rights reserved.
//

#import "Protocol.h"
#import "NSMutableData+TCP.m"

@implementation Protocol
+(NSData*)setTextWithId:(int)Id
                    eng:(int)eng
                    chi:(int)chi
                  color:(int)color
                   stay:(int)stay
                 action:(int)action
                  speed:(int)speed
                allStay:(int)allStay
                   text:(NSData*)text
                  alias:(NSData*)alias{
    NSMutableData* data = [NSMutableData data];
    int engFontMatrix[] = {272, 273, 274, 280, 288, 281};//
    int chiFontMatrix[] = {528, 545, 769, 1280, 1792};
    int actionMatrix[] = {2, 1};
    int stayMatrix[] = {6, 8, 9, 10, 11, 13, 14};
    int speedMatrix[] = {1, 0, 3};
    int allStayMatrix[] = {0, 1, 2, 3, 5, 10, 15};
    int textLen = (int)text.length;
    int aliasLen = (int)alias.length;
    int allLen = textLen + aliasLen + 37;
    int cnLen = textLen + aliasLen;
    
    [data appendByte:0x7e];
    [data appendByte:0x01];
    [data appendByte:0xfe];
    [data appendByte:0xfe];
    [data appendByte:(Byte)(allLen >> 8)];
    [data appendByte:(Byte)allLen];
    
    [data appendByte:0x49];
    [data appendByte:0x4e];
    [data appendByte:0x53];
    [data appendByte:0x54];
    [data appendByte:0x01];//信息属性
    [data appendByte:(Byte)(Id >> 8)];
    [data appendByte:(Byte)(Id)];
    
    [data appendByte:0x00];//x 窗口号
    [data appendByte:0x00];//x MSG号
    [data appendByte:0x00];//保留
    [data appendByte:0x00];//时间始分钟
    [data appendByte:0x00];
    [data appendByte:0x00];//时间止分钟
    [data appendByte:0x00];
    [data appendByte:0x00];//播放时间
    
    [data appendByte:(Byte)(allStayMatrix[allStay])];
    [data appendByte:0x00];
    [data appendByte:(Byte)aliasLen];
    [data appendByte:0x01];
    [data appendByte:0x00];
    [data appendByte:(Byte)color];
    
    [data appendByte:(Byte)(chiFontMatrix[chi] >> 8)];
    [data appendByte:(Byte)(chiFontMatrix[chi])];
    [data appendByte:(Byte)(engFontMatrix[chi] >> 8)];
    [data appendByte:(Byte)(engFontMatrix[chi])];
    [data appendByte:0x00];
    [data appendByte:0x00];
    
    [data appendByte:(Byte)stayMatrix[stay]];//停留时间
    if (action == 11)
    {
        [data appendByte:0x01];
        [data appendByte:0x04];
    }
    else
    {
        [data appendByte:(Byte)(actionMatrix[action])];
        [data appendByte:0x00];
    }
    
    if (actionMatrix[action] == 2 || actionMatrix[action] == 3)
    {
        [data appendByte:(Byte)(speedMatrix[speed])];
    }
    else{
        [data appendByte:0x00];
    }
    [data appendByte:0x00];
    [data appendByte:0x00];
    [data appendByte:0x00];
    [data appendByte:0x00];
    [data appendByte:(Byte)(cnLen >> 8)];
    [data appendByte:(Byte)cnLen];
   
    [data appendData:alias];
    [data appendData:text];
    
    [data appendByte:0xff];
    [data appendByte:0xff];
    [data appendByte:0x7e];
    [data appendByte:0x00];
    return [self transcode:data];
}

+(NSData*)setRomWithSn:(int)sn price:(NSData*)price tip:(NSData*)tip{
    NSMutableData* data = [NSMutableData data];
    [data appendByte:0x7e];
    [data appendByte:0x01];
    [data appendByte:0xfe];
    [data appendByte:0xfe];
    [data appendByte:0x00];
    [data appendByte:(Byte)(7+price.length + tip.length)];
    [data appendByte:0x56];
    [data appendByte:0x52];
    [data appendByte:0x4f];
    [data appendByte:0x4d];
    [data appendByte:(Byte)sn];
    [data appendByte:(Byte)(1 + price.length + tip.length)];
    [data appendData:price];
    [data appendByte:(Byte)'|'];
    [data appendData:tip];
    [data appendByte:0xff];
    [data appendByte:0xff];
    [data appendByte:0x7e];
    [data appendByte:0x00];
    return [data copy];
}


+(NSData*)setRom32:(int)s1_num s2_num:(int)s2_num page:(int)page line:(int)line isM1:(BOOL)isM1 isM2:(BOOL)isM2{
    //0x20 VROM 用于参数配置
    int pageSecondsMatrix[] = {5, 10, 15, 20, 25, 30};
    int lineSecondsMatrix[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    NSMutableData* data = [NSMutableData data];
    [data appendByte:0x7e];
    [data appendByte:0x01];
    [data appendByte:0xfe];
    [data appendByte:0xfe];
    [data appendByte:0x00];
    [data appendByte:(Byte)(14)];
    [data appendByte:0x56];
    [data appendByte:0x52];
    [data appendByte:0x4f];
    [data appendByte:0x4d];
    [data appendByte:0x20];
    [data appendByte:(Byte)8];
    
    [data appendByte:(Byte)s1_num];
    [data appendByte:(Byte)s2_num];
    [data appendByte:(isM1 ? 0xaa: 0x00)];
    [data appendByte:(isM2 ? 0xaa: 0x00)];
    [data appendByte:pageSecondsMatrix[page]];
    [data appendByte:lineSecondsMatrix[page]];
    
    [data appendByte:0x00];
    [data appendByte:0x00];
    [data appendByte:0xff];
    [data appendByte:0xff];
    [data appendByte:0x7e];
    [data appendByte:0x00];
    return [data copy];
}

+(NSData*)setBrightWithMode:(int)mode level:(int)level{
    NSMutableData* data = [NSMutableData data];
    [data appendByte:0x7e];
    [data appendByte:0x01];
    [data appendByte:0xfe];
    [data appendByte:0xfe];
    [data appendByte:0x00];
    [data appendByte:0x14];
    [data appendByte:0x42];
    [data appendByte:0x52];
    [data appendByte:0x49];
    [data appendByte:0x47];
    [data appendByte:0x04];
    [data appendByte:(Byte)mode];
    [data appendByte:(Byte)level];
    
    [data appendByte:0x00];
    [data appendByte:0x00];
    [data appendByte:0x00];
    [data appendByte:0x00];
    [data appendByte:0x00];
    [data appendByte:0x00];
    [data appendByte:0x00];
    [data appendByte:0x00];
    [data appendByte:0x00];
    [data appendByte:0x00];
    [data appendByte:0x00];
    [data appendByte:0x00];
    [data appendByte:0x00];
    
    [data appendByte:0xff];
    [data appendByte:0xff];
    [data appendByte:0x7e];
    [data appendByte:0x00];
    return [data copy];
}


+(NSData*)transcode:(NSData*)data{
    NSMutableData* result = [NSMutableData dataWithData:data];
    for(int i = (int)(data.length - 3); i> 1; i--){
        Byte* ptr = (Byte*)data.bytes;
        if (ptr[i] == 0x7e){
            Byte placement[2] = {0x02, 0x7d};
            NSRange range =NSMakeRange(i, 1);
            [result replaceBytesInRange:range withBytes:placement length:2];
        }
        else if (ptr[i] == 0x7d){
            Byte placement[2] = {0x01, 0x7d};
             NSRange range =NSMakeRange(i, 1);
             [result replaceBytesInRange:range withBytes:placement length:2];
        }
    }
    return result.copy;
}
@end
