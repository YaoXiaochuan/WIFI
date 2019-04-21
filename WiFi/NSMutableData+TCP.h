//
//  NSMutableData+TCP.h
//  WiFi
//
//  Created by 李兰芳 on 2019/4/20.
//  Copyright © 2019年 YaoXiaochuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableData (TCP)
-(void)appendByte:(Byte)byte;
-(void)appendUInt:(NSUInteger)value;
@end
