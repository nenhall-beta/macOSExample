//
//  IPCClientProxy.h
//  IPC_Client
//
//  Created by meitu@nenhall on 2022/12/12.
//

#import <Foundation/Foundation.h>
#import <IPCCommunicator/IPCCommunicator.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IPCClientProxyDelegate <NSObject>

- (void)doSomethingByServer:(NSString*)test;

@end

@interface IPCClientProxy : IPCBaseSubAppClientProxy
-(void)notifyDoSomething;

@end

NS_ASSUME_NONNULL_END
