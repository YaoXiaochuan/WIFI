//
//  Protocol.h
//  WiFi
//
//  Created by 李兰芳 on 2019/4/20.
//  Copyright © 2019年 YaoXiaochuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Protocol : NSObject
+(int)HexToBcd:(int)hex;
+(NSData*)transcode:(NSData*)data;
+(NSData*)requestVersion;//查询版本
+(NSData*)setPower:(int)code;

+(NSData*)deletePlayId:(int)startId  endId:(int)endId;


+(NSData*)setTextWithId:(int)Id
                    eng:(int)eng
                    chi:(int)chi
                  color:(int)color
                   stay:(int)stay
                 action:(int)action
                  speed:(int)speed
                allStay:(int)allStay
                   text:(NSData*)text
                  alias:(NSData*)alias;

+(NSData*)setRomWithSn:(int)sn price:(NSData*)price tip:(NSData*)tip;
+(NSData*)setRom32:(int)s1_num s2_num:(int)s2_num page:(int)page line:(int)line isM1:(BOOL)isM1 isM2:(BOOL)isM2;
+(NSData*)setBrightWithCode:(int)code level:(int)level;
@end
