//
//  ViewController.swift
//  IPC_Client
//
//  Created by meitu@nenhall on 2022/12/11.
//

import Cocoa

class ViewController: NSViewController {

    var messagePort: CFMessagePort?
    var callBack: CFMessagePortCallBack?
    @IBOutlet var textView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        createMessagePort(nil)
//        addDistributedNotification(nil)
    }
    
    @IBAction func notifyServer(_ sender:Any?) {
        (NSApp.delegate as? AppDelegate)?.notifyServer(sender)
    }
}

extension ViewController {
    
    @IBAction func createMessagePort(_ send: NSButton?) {
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMessage), name: NSNotification.Name("port.message"), object: nil)

        self.callBack = { (port: CFMessagePort?, msgid: Int32, data: CFData?, pointer: UnsafeMutableRawPointer?) -> Unmanaged<CFData>? in
            let resultString = String(data: data! as Data, encoding: .utf8) ?? ""
            let returnData = "你发的消息已收到了:\(resultString)".data(using: .utf8)! as CFData
            let cfData = Unmanaged<CFData>.passRetained(returnData)
            NotificationCenter.default.post(name: NSNotification.Name("port.message"), object: resultString)
            return cfData
        }
        let name = "com.mach.port.sevrice" as CFString
        let port = CFMessagePortCreateLocal(kCFAllocatorDefault, name, callBack, nil, nil)
        messagePort = port
        let source = CFMessagePortCreateRunLoopSource(kCFAllocatorDefault, port, 0)
        CFRunLoopAddSource(CFRunLoopGetCurrent(), source, CFRunLoopMode.commonModes)
    }
    
    @IBAction func addDistributedNotification(_ send: NSButton?) {
        DistributedNotificationCenter.default().addObserver(self, selector: #selector(didReceiveMessage), name: NSNotification.Name("test.distributed.nofitication"), object: nil)
    }
    
    @objc func didReceiveMessage(_ note: Notification) {
        if note.name.rawValue == "port.message" {
            textView.string.append(note.object as? String ?? "")
        } else {
            textView.string.append(note.object as! String)
        }
        textView.string.append("\n")
    }
}


