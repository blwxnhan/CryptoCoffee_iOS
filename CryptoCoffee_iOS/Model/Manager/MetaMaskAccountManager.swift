//
//  MetaMaskAccountManager.swift
//  CryptoCoffee_iOS
//
//  Created by Bowon Han on 5/20/24.
//

import Foundation

class MetaMaskAccountManager {
    var account = MetaMaskAccountModel(account: "")
    
    static let shared = MetaMaskAccountManager()

    private init() {}
}
