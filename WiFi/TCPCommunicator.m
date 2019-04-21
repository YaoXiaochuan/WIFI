
//
//  TCPCommunicator.m
//  WiFi
//
//  Created by 李兰芳 on 2019/4/20.
//  Copyright © 2019年 YaoXiaochuan. All rights reserved.
//

#import "TCPCommunicator.h"
#import "GCDAsyncSocket.h"

@interface TCPCommunicator()<GCDAsyncSocketDelegate>
@property(nonatomic, assign) long writeTag;
@property(nonatomic, assign) BOOL isConnected;
@property(nonatomic, strong) GCDAsyncSocket* socket;
@property(nonatomic, strong) NSString *host;
@property(nonatomic, assign) NSUInteger port;
@property(nonatomic, strong) NSMutableDictionary<NSData*> *sendCommands;
@property(nonatomic, strong) NSMutableData* receiveData;

@end

@implementation TCPCommunicator

- (instancetype)init{
    self = [super init];
    if (self) {
        self.host = @"";
        self.port = 2015;
       
        
    }
    return self;
}

- (void)connectWithCompletionHandler:(void (^_Nullable)(NSError * _Nullable error))completion{
    NSError* error;
    if (self.isConnected == NO){
        self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self  delegateQueue:nil];
        [self.socket connectToHost:self.host onPort:self.port error:&error];
    }
    
    if(completion){
        
    }
}

-(void)sendCommands:(NSMutableArray<NSData*>*)commands{
    self.sendCommands = [NSMutableDictionary<NSNumber*,NSData*> dictionary];
    NSArray<NSData*>* sendCommands = [commands copy];
    if(self.isConnected){
        long tag = self.writeTag;
        self.writeTag += 1;
        if(self.writeTag > NSIntegerMax){
            self.writeTag = 0;
        }
    
        for (NSData* data in sendCommands) {
            [self.sendCommands setObject:data forKey:@(tag)];
            [self.socket writeData:data withTimeout:-1 tag:tag];
        }
        
    }else{
        NSLog(@"connection fail");
    }
   
}

#pragma mark - GCDAsyncSocketDelegate

-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    self.isConnected = YES;
    self.writeTag = 0;
    self.receiveData = [NSMutableData data];
    [self.socket readDataWithTimeout:-1 tag:0];
    
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    self.isConnected = NO;
    self.socket = nil;
    [self.sendCommands removeAllObjects];
    self.receiveData = nil;
    NSLog(@"socketDidDisconnect:withError %@", err);
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"socket:didReadData: %@", data);
    [self.receiveData appendData:data];
    [self.sendCommands removeObjectForKey:@(tag)];
    if(self.sendCommands.count == 0){
        NSLog(@"all data has been sent!");
    }
    [self.socket readDataWithTimeout:-1 tag:0];
}
@end
