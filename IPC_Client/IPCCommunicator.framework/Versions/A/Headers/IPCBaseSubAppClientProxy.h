//
//  IPCSubAppClient.h
//
//  Created by fancymax on 21/12/2017.
//  Copyright © 2017 Wondershare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPCConnectionStatus.h"

NS_ASSUME_NONNULL_BEGIN

@class IPCBaseSubAppClientProxy;

@protocol IPCSubAppClientConnectionDelegate <NSObject>
/**
 Client 收到 server 连接断开的通知
 */
- (void)subAppClientProxyDidReceiveConnectionDie:(IPCBaseSubAppClientProxy *)clientProxy;

/**
 与 server 成功建立连接
 */
- (void)subAppClientProxyDidConnect:(IPCBaseSubAppClientProxy *)clientProxy;
@end

/**
 Sub app 与 Host app 建立连接的对象。
 
 在 sub app 中使用, 也就是客户端.
 */
@interface IPCBaseSubAppClientProxy : NSObject

@property (readonly, assign) IPCConnectionStatus connectionStatus;

@property (readonly,strong) id connection;

/** Proxy delegate, 用于主程序与子程序间的信息交换. */
@property (nonatomic, weak, nullable) id delegate;

/** 服务器连接断开 delegate */
@property (nonatomic, weak, nullable) id <IPCSubAppClientConnectionDelegate> connectionDelegate;

/** 开始与 Host app(服务端)建立连接。 */
- (void)establishConnection;

@end

NS_ASSUME_NONNULL_END


