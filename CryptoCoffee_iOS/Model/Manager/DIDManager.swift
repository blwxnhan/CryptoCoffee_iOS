//
//  DIDManager.swift
//  CryptoCoffee_iOS
//
//  Created by Bowon Han on 5/13/24.
//

import Foundation

class DIDManager {
    var DIDList = DIDModel(DIDList: [""])
    
    static let shared = DIDManager()

    private init() {}
}
