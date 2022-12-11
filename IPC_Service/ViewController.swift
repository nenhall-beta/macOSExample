//
//  ViewController.swift
//  IPC_Service
//
//  Created by meitu@nenhall on 2022/12/11.
//

import Cocoa

class ViewController: NSViewController {

    var remotePort = CFMessagePortCreateRemote(kCFAllocatorDefault, "com.mach.port.sevrice" as CFString)
    var callBack: CFMessagePortCallBack?
    var dataPtr: UnsafeMutablePointer<Unmanaged<CFData>?>?
    var cfData: Unmanaged<CFData>?

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var textView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension ViewController {
    
    @IBAction func sendPortMessage(_ send: NSButton?) {
        guard let remotePort = remotePort else {
            textView.string.append("port is null")
            textView.string.append("\n")
            self.remotePort = CFMessagePortCreateRemote(kCFAllocatorDefault, "com.mach.port.sevrice" as CFString)
            return
        }
        
        let msgid = Date().timeIntervalSince1970
        let replyMode = CFRunLoopMode.defaultMode.rawValue as CFString
        let dataPtr = withUnsafeMutablePointer(to: &cfData) { point in
            point
        }
//        self.dataPtr = dataPtr
        let result = CFMessagePortSendRequest(remotePort, Int32(msgid), textField.stringValue.data(using: .utf8)! as CFData, 0, 60, replyMode, dataPtr)
        if let pointee = dataPtr.pointee {
            let resultString = String(data: pointee.takeRetainedValue() as Data, encoding: .utf8)
            textView.string.append(resultString ?? "")
            textView.string.append("\n")
        }
        print(result)
    }
    
    @IBAction func sendDistributedNotification(_ send: NSButton?) {
        DistributedNotificationCenter.default().postNotificationName(NSNotification.Name("test.distributed.nofitication"), object: "DistributedNotificationCenter", userInfo: ["key": "value"], deliverImmediately: true)
    }
    
    @objc func didReceiveMessage(_ note: Notification) {
        if note.name.rawValue == "com.mach.port.sevrice" {
            textView.string.append(String(data: note.object as! Data, encoding: .utf8) ?? "")
        } else {
            textView.string.append(note.object as! String)
        }
        textView.string.append("\n")
    }
}

