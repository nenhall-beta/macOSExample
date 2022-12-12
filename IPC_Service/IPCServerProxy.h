//
//  IPCDemoServerProxy.h
//  IPC_Service
//
//  Created by meitu@nenhall on 2022/12/12.
//

#import <Foundation/Foundation.h>
#import <IPCCommunicator/IPCCommunicator.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IPCDemoServerProxyDelegate <NSObject>

- (void)notifyDoSomething;

@end

@interface IPCServerProxy : IPCBaseSubAppServerProxy

-(void)doSomething:(NSString*) test;

@end

NS_ASSUME_NONNULL_END
