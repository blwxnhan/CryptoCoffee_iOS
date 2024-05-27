//
//  UserDefault.swift
//  CryptoCoffee_iOS
//
//  Created by Bowon Han on 5/23/24.
//

import Foundation

final class DIDUserDefaults {
    static let shared = DIDUserDefaults()

    var DIDList: DIDModel?

    private init() {}

    func saveData() {
        let userDefaults = UserDefaults.standard

        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(DIDList){
            userDefaults.set(encoded, forKey: "DID")
        }
    }

    func loadData() {
        let userDefaults = UserDefaults.standard

        if let savedData = userDefaults.object(forKey: "DID") as? Data {
            let decoder = JSONDecoder()
            if let savedObject = try? decoder.decode(DIDModel?.self, from: savedData){
                DIDList = savedObject
                print(DIDList)
            }
        }
    }
}
