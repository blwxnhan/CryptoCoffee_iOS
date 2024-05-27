//
//  UserDefault.swift
//  CryptoCoffee_iOS
//
//  Created by Bowon Han on 5/23/24.
//

import Foundation

final class CryptoUserDefaults {
    static let shared = CryptoUserDefaults()

    var DIDList = DIDModel(did: "")
    var account = MetaMaskAccountModel(account: "")

    private init() {}

    func saveDIDData() {
        let userDefaults = UserDefaults.standard

        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(DIDList){
            userDefaults.set(encoded, forKey: "DID")
        }
    }

    func loadDIDData() {
        let userDefaults = UserDefaults.standard

        if let savedData = userDefaults.object(forKey: "DID") as? Data {
            let decoder = JSONDecoder()
            if let savedObject = try? decoder.decode(DIDModel?.self, from: savedData){
                DIDList = savedObject
            }
        }
    }
    
    func saveAccountData() {
        let userDefaults = UserDefaults.standard

        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(account){
            userDefaults.set(encoded, forKey: "account")
        }
    }

    func loadAccountData() {
        let userDefaults = UserDefaults.standard

        if let savedData = userDefaults.object(forKey: "account") as? Data {
            let decoder = JSONDecoder()
            if let savedObject = try? decoder.decode(MetaMaskAccountModel?.self, from: savedData){
                account = savedObject
            }
        }
    }
}
