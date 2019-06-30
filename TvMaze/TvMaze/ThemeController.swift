//
//  Theme.swift
//  TvMaze
//
//  Created by Consultant on 6/27/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class ThemeController {
  let shared = ThemeController()
  private init() { }
  
  enum Theme {
    case light, dark
  }
  
  var currentTheme: Theme = .light
  
  var backgroundColor: UIColor {
    get {
      switch currentTheme {
      case .light:
        return UIColor.white
      case .dark:
        return UIColor.black
      }
    }
  }
  var textColor: UIColor {
    get {
      switch currentTheme {
      case .light:
        return UIColor.darkText
      case .dark:
        return UIColor.lightText
      }
    }
  }
  var tintColor: UIColor {
    get {
      return UIColor.blue
    }
  }
}
