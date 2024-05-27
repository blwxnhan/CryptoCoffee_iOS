//
//  MetaMaskAccountManager.swift
//  CryptoCoffee_iOS
//
//  Created by Bowon Han on 5/20/24.
//

import Foundation

//final class MetaMaskAccountUserDefaults {
//    static let shared = MetaMaskAccountUserDefaults()
//
//    var account: MetaMaskAccountModel?
//
//    private init() {}
//
//    func saveData() {
//        let userDefaults = UserDefaults.standard
//
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(account) {
//            userDefaults.set(encoded, forKey: "Metamask")
//        }
//    }
//
//    func loadData() {
//        let userDefaults = UserDefaults.standard
//
//        if let savedData = userDefaults.object(forKey: "Metamask") as? Data {
//            let decoder = JSONDecoder()
//            if let savedObject = try? decoder.decode(MetaMaskAccountModel?.self, from: savedData) {
//                account = savedObject
//                print(account)
//            }
//        }
//    }
//}

final class MetaMaskAccountUserDefaults {
    static let shared = MetaMaskAccountUserDefaults()

    var account = MetaMaskAccountModel(account: "")

    private init() {}
}
