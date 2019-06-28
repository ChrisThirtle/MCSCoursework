//
//  Theme.swift
//  TvMaze
//
//  Created by Consultant on 6/27/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class Theme {

  var currentTheme: ColorScheme = .light
  
  enum ColorScheme {
    case light, dark
  }
  
  func backgroundColor1(scheme: ColorScheme) -> UIColor {
    switch scheme {
    case .light:
      return UIColor.white
    case .dark:
      return UIColor.black
    }
  }
  
  func backgroundColor2(scheme: ColorScheme) -> UIColor {
    switch scheme {
    case .light:
      return UIColor.lightGray
    case .dark:
      return UIColor.darkGray
    }
  }
  
  func textColor(scheme: ColorScheme) -> UIColor {
    switch scheme {
    case .light:
      return UIColor.black
    case .dark:
      return UIColor.white
    }
  }
  
  func tintColor(scheme: ColorScheme) -> UIColor {
    return UIColor.blue
  }
  
}

class ThemeController {
  static let shared = ThemeController()
  
  private init() { }
  
  static var currentTheme = Theme()
  
  static func changeTheme() {
    UITableView.appearance().backgroundColor = currentTheme?.backgroundColor
    UITableViewCell.appearance().backgroundColor = currentTheme?.backgroundColor
    UIView.appearance(whenContainedInInstancesOf: [EpisodeDetailViewController.self]).backgroundColor = currentTheme?.backgroundColor
    UILabel.appearance().textColor = currentTheme?.textColor
  }
}
