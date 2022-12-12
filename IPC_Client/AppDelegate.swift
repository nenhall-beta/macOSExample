//
//  AppDelegate.swift
//  IPC_Client
//
//  Created by meitu@nenhall on 2022/12/11.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    lazy var clientProxy: IPCClientProxy = {
        return IPCClientProxy()
    }()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        clientProxy.establishConnection()
        clientProxy.delegate = self
        clientProxy.connectionDelegate = self
    }
    
    @IBAction func notifyServer(_ sender:Any?) {
        clientProxy.notifyDoSomething()
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}

extension AppDelegate: IPCClientProxyDelegate {
    func doSomething(byServer test:String){
        NSLog("Client:do something by told \(test)")
    }
}

extension AppDelegate: IPCSubAppClientConnectionDelegate {
    
    func subAppClientProxyDidConnect(_ clientProxy: IPCBaseSubAppClientProxy) {
        
    }
    
    func subAppClientProxyDidReceiveConnectionDie(_ clientProxy: IPCBaseSubAppClientProxy) {
        
        DispatchQueue.main.async {
            NSApp.terminate(nil)
        }

        print("subAppClientProxyDidReceiveConnectionDie")
    }
}

