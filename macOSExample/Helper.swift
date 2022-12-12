//
//  File.swift
//  macOSExample
//
//  Created by meitu@nenhall on 2022/12/12.
//

import Foundation

class Helper {
    
    static let shared = Helper()
    
    lazy var connection: NSXPCConnection = {
        //创建connection服务
        let connection = NSXPCConnection(serviceName: "com.ipc.lient.helper")
        //注册协议接口
        connection.remoteObjectInterface = NSXPCInterface(with: HelperProtocol.self)
        //同步等待连接建立
        connection.resume()
        return connection
    }()
    
    //获取远程对象
    var remoteProxy: HelperProtocol {
        connection.remoteObjectProxyWithErrorHandler {
            (error) in print("remote proxy error: \(error)")
        } as! HelperProtocol
    }
    
    private init() {
        
    }
    
    func sendMessag(_ text: String, callBack: @escaping (_ result: String) -> Void) {
        remoteProxy.uppercase(string: text) { result in
            DispatchQueue.main.async {
                callBack(result)
            }
        }
    }
    
    deinit {
        self.connection.invalidate()
    }
}
