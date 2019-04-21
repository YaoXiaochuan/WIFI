//
//  ViewController.m
//  WiFi
//
//  Created by 李兰芳 on 2019/4/20.
//  Copyright © 2019年 YaoXiaochuan. All rights reserved.
//

#import "ViewController.h"
#import "TCPCommunicator.h"
#import "Protocol.h"

@interface ViewController ()
@property (nonatomic, strong) TCPCommunicator* communicator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.communicator = [[TCPCommunicator alloc] init];
    
    
    
   
}


-(void)sendClick:(UIButton*)sender{
    int s1_num = 0, s2_num = 0;
    int s1 = 0, s2 = 0x10, j;
    Byte* textArray = NULL, *aliasArray = NULL;
    Byte* priceArray = NULL, *tipArray = NULL, *tempArray = NULL;
    
}




@end
