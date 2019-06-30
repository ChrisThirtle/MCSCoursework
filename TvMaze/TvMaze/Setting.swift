//
//  Setting.swift
//  TvMaze
//
//  Created by Consultant on 6/27/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation

class Setting {
  var description: String
  var value: Bool {
    get {
      return UserDefaults.standard.bool(forKey: description)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: description)
    }
  }
  
  init(_ name: String) {
    self.description = name
  }
}
