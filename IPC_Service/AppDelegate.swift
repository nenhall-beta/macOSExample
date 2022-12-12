//
//  AppDelegate.swift
//  IPC_Service
//
//  Created by meitu@nenhall on 2022/12/11.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var serverProxy: IPCServerProxy?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let socketParentPath = "~/Library/Caches/com.nenhall.ipc.service/" as NSString
        let realPath = socketParentPath.expandingTildeInPath
        let _ = makeSureDirectoryExist(realPath)
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    @IBAction func releaseServerProxy(_ sender: NSButton) {
        guard let serverProxy = serverProxy else { return }
        serverProxy.closeClient()
        self.serverProxy = nil;
    }
    
    @IBAction func invokeClient(_ sender:Any?) {
        if serverProxy == nil {
           let serverProxy = IPCServerProxy(appName: "IPC_Client")
            serverProxy.delegate = self
            serverProxy.connectionDelegate = self
            serverProxy.launchClient()
            self.serverProxy = serverProxy
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                //self.serverProxy.doSomething()
                let test = "i am server"
                serverProxy.doSomething(test)
            }
        } else {
            let test = "i am server"
            self.serverProxy?.doSomething(test)
        }
    }
    
    private func makeSureDirectoryExist(_ directory:String) -> Bool {
        let isExistDirectory:Bool = FileManager.default.fileExists(atPath: directory, isDirectory: nil)
        if !isExistDirectory {
            do{
                try FileManager.default.createDirectory(atPath: directory, withIntermediateDirectories: true, attributes: nil)
                return true
            }
            catch {
                print("Creat \(directory) fail")
                return false
            }
        }
        return true
    }
}

extension AppDelegate:IPCDemoServerProxyDelegate {
    func notifyDoSomething() {
        DispatchQueue.main.async {
            NSLog("Server:notify by client do something")
        }
    }
}

extension AppDelegate: IPCSubAppServerConnectionDelegate {
    
    func subAppServerProxyDidReady(_ serverProxy: IPCBaseSubAppServerProxy) {
        
    }
    
    func subAppServerProxyDidReceiveConnectionDie(_ serverProxy: IPCBaseSubAppServerProxy) {
        
    }
}
