//
//  Error.swift
//  CryptoCoffee_iOS
//
//  Created by Bowon Han on 5/13/24.
//

import Foundation

enum FetchError: Error {
    case invalidStatus
    case jsonDecodeError
}
