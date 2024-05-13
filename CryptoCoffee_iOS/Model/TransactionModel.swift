//
//  Model.swift
//  CryptoCoffee_iOS
//
//  Created by Bowon Han on 5/13/24.
//

import Foundation
import metamask_ios_sdk
 
struct Transaction: CodableData {
  let to: String
  let from: String
  let value: String
  let data: String?

  init(to: String, from: String, value: String, data: String? = nil) {
    self.to = to
    self.from = from
    self.value = value
    self.data = data
  }

  func socketRepresentation() -> NetworkData {
    [
      "to": to,
      "from": from,
      "value": value,
      "data": data
    ]
  }
}
