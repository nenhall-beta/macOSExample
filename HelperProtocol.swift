//
//  HelperProtocol.swift
//  Helper
//
//  Created by meitu@nenhall on 2022/12/12.
//

import Foundation

@objc protocol HelperProtocol {
    
    func uppercase(string: String, with reply: @escaping (String) -> Void)
}
