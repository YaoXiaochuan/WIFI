//
//  TCPCommunicator.h
//  WiFi
//
//  Created by 李兰芳 on 2019/4/20.
//  Copyright © 2019年 YaoXiaochuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCPCommunicator : NSObject
- (void)connectWithCompletionHandler:(void (^_Nullable)(NSError * _Nullable error))completion;
- (void)disconnect;
- (void)sendCommands:(NSMutableArray<NSData*>*)commands;

@end
