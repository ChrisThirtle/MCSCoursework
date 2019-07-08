//
//  NextPage.swift
//  GoTAPICrawlingProject
//
//  Created by Consultant on 7/2/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation

enum PageType {
  case dictionary([String: Any])
  case array([Any])
  
  static func getPage(from data: CrawlData,
                      completion: @escaping (PageType?) -> Void) {
    switch data {
    case .dictionary(let dictionary):
      completion(.dictionary(dictionary))
    case .array(let array):
      completion(.array(array))
    case .url(let url):
      getPage(from: url, completion: completion)
    default:
      completion(nil)
    }
  }
  
  static func getPage(using networkController: NetworkProtocol = NetworkController(),
            from urlString: String,
            completion: @escaping (PageType?) -> Void) {
    guard let url = URL(string: urlString) else {
      completion(nil)
      return
    }
    networkController.getData(url: url) { (data, error) in
      guard let data = data,
        let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) else {
          completion(nil)
          return
      }
      switch jsonObject {
      case is [String: Any]:
        let jsonObject = jsonObject as! [String: Any]
        completion(PageType.dictionary(jsonObject))
      case is [Any]:
        let jsonObject = jsonObject as! [Any]
        completion(PageType.array(jsonObject))
      default:
        completion(nil)
      }
    }
  }
  
  //MARK: Collection operators
  var count: Int {
    switch self {
    case .dictionary(let dictionary):
      return dictionary.count
    case .array(let array):
      return array.count
    }
  }
  
  func getCrawlData(from index: Int) -> CrawlData? {
    if index < 0 || index > self.count { return nil }
    switch self {
    case .dictionary(let dictionary):
      let key = Array(dictionary.keys)[index]
      return CrawlData.get(for: dictionary[key])
    case .array(let array):
      return CrawlData.get(for: array[index])
    }
  }
}
