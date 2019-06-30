//
//  Theme.swift
//  TvMaze
//
//  Created by Consultant on 6/27/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

protocol Themeable {
  func changeTheme()
}

class ThemeController {
  static let shared = ThemeController()
  private init() {
    let nightMode = Setting(.nightMode).value
    if nightMode {
      currentTheme = .dark
    }
    else {
      currentTheme = .light
    }
  }
  
  enum Theme: String {
    case light, dark
  }
  
  var themeableViews = [Themeable]()
  
  static func registerThemeable(_ obj: Themeable) {
    shared.themeableViews.append(obj)
    obj.changeTheme()
  }
  
  
  var currentTheme: Theme {
    didSet {
      for view in themeableViews {
        view.changeTheme()
      }
    }
  }
  
  var mainColor: UIColor {
    switch currentTheme {
    case .light:
      return UIColor.white
    case .dark:
      return UIColor.black
    }
  }
  var secondaryColor: UIColor {
    switch currentTheme {
    case .light:
      return UIColor(white: 0.95, alpha: 1)
    case .dark:
      return UIColor(white: 0.05, alpha: 1)
    }
  }
  var textColor: UIColor {
    switch currentTheme {
    case .light:
      return UIColor.darkText
    case .dark:
      return UIColor.lightText
    }
  }
  var tintColor: UIColor {
    switch currentTheme {
    case .light:
      return UIColor.blue
    case .dark:
      return UIColor.cyan
    }
  }
  var highlightColor: UIColor {
    switch currentTheme {
    case .light:
      return UIColor.gray.withAlphaComponent(0.5)
    case .dark:
      return UIColor.darkGray.withAlphaComponent(0.5)
    }
  }
  var barStyle: UIBarStyle {
    
    switch currentTheme {
    case .light:
      return .default
    case .dark:
      return .black
    }
  }
}
