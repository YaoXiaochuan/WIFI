//
//  NSMutableData+TCP.m
//  WiFi
//
//  Created by 李兰芳 on 2019/4/20.
//  Copyright © 2019年 YaoXiaochuan. All rights reserved.
//

#import "NSMutableData+TCP.h"

@implementation NSMutableData (TCP)
-(void)appendByte:(Byte)byte{
  [self appendBytes:&byte length:sizeof(Byte)];
}

- (void)appendUInt:(NSUInteger)value{
    Byte byteH = (value >> 8);
    Byte byteL = value;
    [self appendBytes:&byteH length:1];
    [self appendBytes:&byteL length:1];
}

@end
