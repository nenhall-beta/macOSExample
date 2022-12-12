//
//  Helper.swift
//  Helper
//
//  Created by meitu@nenhall on 2022/12/12.
//

import Foundation

class Helper: NSObject, HelperProtocol {
    
    @objc func uppercase(string: String, with reply: @escaping (String) -> Void) {
        let response = string.uppercased()
        reply("xpc 收到的消息：\(response)")
    }
}
