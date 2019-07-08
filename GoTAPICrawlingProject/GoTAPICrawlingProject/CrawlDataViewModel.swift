//
//  CrawlerView.swift
//  GoTAPICrawlingProject
//
//  Created by Consultant on 7/2/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation

protocol CrawlDataStringifier {
  func titleString(for page: PageType, index: Int) -> String
  func detailString(for data: CrawlData) -> String
  func titleAndDetailString(for page: PageType, index: Int) -> (String, String)
}

class CrawlDataViewModel: CrawlDataStringifier {
  func titleString(for page: PageType, index: Int) -> String {
    switch page {
    case .array(_):
      return "Index \(index)"
    case .dictionary(let dictionary):
      let keys = Array(dictionary.keys)
      return keys[index]
    }
  }
  
  func detailString(for data: CrawlData) -> String {
    let detailString: String = {
      switch data {
      case .dictionary(let dictionary):
        return "Dictionary with \(dictionary.count) entries"
      case .array(let array):
        return "Array with \(array.count) elements"
      case .string (let string), .url (let string):
        return string
      case .bool (let value):
        return "\(value)"
      case .number (let value):
        return "\(value)"
      case .null(_):
        return "NULL"
      }
    }()
    return !detailString.isEmpty
      ? detailString
      : "No entry provided"
  }
  
  func titleAndDetailString(for page: PageType, index: Int) -> (String, String) {
    let titleString = self.titleString(for: page, index: index)
    guard let data = page.getCrawlData(from: index) else { return ("","") }
    let detailString: String = self.detailString(for: data)
    return (titleString.capitalized, detailString)
  }
}
