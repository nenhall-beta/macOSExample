//
//  IPCClientProxy.m
//  IPC_Client
//
//  Created by meitu@nenhall on 2022/12/12.
//

#import "IPCClientProxy.h"

@implementation IPCClientProxy

-(void)doSomething:(NSString *)test {
    if (self.delegate && [self.delegate respondsToSelector:@selector(doSomethingByServer:)]) {
        [self.delegate doSomethingByServer:test];
        [self notifyDoSomething];
    }
}

-(void)notifyDoSomething {
    [self.connection notifyDoSomething];
}

@end
