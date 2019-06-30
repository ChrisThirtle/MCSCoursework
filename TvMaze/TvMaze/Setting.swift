//
//  Setting.swift
//  TvMaze
//
//  Created by Consultant on 6/27/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation

class Setting {
  var description: Settings
  var value: Bool {
    get {
      return UserDefaults.standard.bool(forKey: description.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: description.rawValue)
      switch description {
      case .nightMode:
        ThemeController.shared.currentTheme = newValue ? .dark : .light
      }
    }
  }
  
  init?(name: String) {
    guard let description = Settings.init(rawValue: name) else {
      return nil
    }
    self.description = description
  }
  
  init(_ setting: Settings) {
    self.description = setting
  }
  
  enum Settings: String, RawRepresentable {
    case nightMode = "Night Mode"
  }
}
