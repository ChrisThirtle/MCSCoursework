//
//  Pokemon.swift
//  RealmProject
//
//  Created by Consultant on 7/9/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation
import RealmSwift

class Pokemon: Object, Codable {
  @objc dynamic var name: String = ""
  
  @objc override class func primaryKey() -> String? { return "name" }

  convenience init?(pokemon: Pokemon) {
    self.init()
    self.name = pokemon.name
  }
  
  static func ==(lhs: Pokemon, rhs: Pokemon) -> Bool {
    return lhs.name == rhs.name
  }
}
