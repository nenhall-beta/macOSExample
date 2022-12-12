//
//  IPCConnectionStatus.h
//  IPCCommunicator
//
//  Created by Xie Linhua on 9/7/21.
//  Copyright © 2021 Wondershare. All rights reserved.
//  

#ifndef IPCConnectionStatus_h
#define IPCConnectionStatus_h

#import <Foundation/Foundation.h>

/** Host app 与 sub app 之间的连接状态 */
typedef NS_ENUM(NSInteger, IPCConnectionStatus) {
    IPCConnectionStatusDisconnected,
    IPCConnectionStatusConnecting,
    IPCConnectionStatusConnected
};

#endif /* IPCConnectionStatus_h */
