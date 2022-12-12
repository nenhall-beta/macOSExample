//
//  IPCSubAppServer.h
//
//  Created by fancymax on 21/12/2017.
//  Copyright © 2017 Wondershare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPCConnectionStatus.h"

NS_ASSUME_NONNULL_BEGIN

@class IPCBaseSubAppServerProxy;

@protocol IPCSubAppServerConnectionDelegate <NSObject>

/**
 Server 已经做好 client 的连接请求的准备
 */
- (void)subAppServerProxyDidReady:(IPCBaseSubAppServerProxy *)serverProxy;

/**
 Server 收到 client 连接断开的通知
 */
- (void)subAppServerProxyDidReceiveConnectionDie:(IPCBaseSubAppServerProxy *)serverProxy;
@end

/**
 Host app 用来 启动/关闭 sub app 的控制对象。
 
 在 host app 中使用, 也就是服务端.
 */
@interface IPCBaseSubAppServerProxy : NSObject

@property (readonly, assign) IPCConnectionStatus connectionStatus;

@property (readonly, assign) BOOL isAlive;

@property (readonly, strong) id connection;

/** Proxy delegate, 用于 host app 与 sub app 间的信息交换. */
@property (nonatomic, weak, nullable) id delegate;

/** 客户端(sub app)连接断开 delegate */
@property (nonatomic, weak, nullable) id <IPCSubAppServerConnectionDelegate> connectionDelegate;

- (instancetype)init NS_UNAVAILABLE;

/**
 创建调用子程序的 server proxy 对象
 
 @param appName Sub app 的名字, 如 `ScreenRecord`.
 */
- (instancetype)initWithAppName:(NSString*)appName;

/** 启动子程序 */
- (void)launchClient;

/** 关闭子程序 */
- (void)closeClient;

@end

NS_ASSUME_NONNULL_END
