//
//  IPCDemoServerProxy.m
//  IPC_Service
//
//  Created by meitu@nenhall on 2022/12/12.
//

#import "IPCServerProxy.h"

@implementation IPCServerProxy

-(void)doSomething:(NSString*) test {
    [self.connection doSomething: test];
}

-(void)notifyDoSomething {
    if (self.delegate && [self.delegate respondsToSelector:@selector(notifyDoSomething)]) {
        [self.delegate notifyDoSomething];
    }
}

@end
