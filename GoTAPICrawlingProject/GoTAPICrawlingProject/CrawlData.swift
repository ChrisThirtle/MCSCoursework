//
//  DataType.swift
//  GoTAPICrawlingProject
//
//  Created by Consultant on 7/2/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

//A unified datatype for all objects serialized by JSON
//Allowed basic objects are strings, numbers, booleans, and nulls
//Allowed collections are dictionaries and arrays
//URLs, dictionaries, and arrays are special in that they are also pages in themselves


import Foundation

enum CrawlData {
  
  case url(String)
  case dictionary([String: Any])
  case array([Any])
  case string(String)
  case number(NSNumber)
  case bool(Bool)
  case null(NSNull)
  
  static func get(for object: Any) -> CrawlData {
    switch object {
    case is [String: Any]:
      let object = object as? [String:Any] ?? [:]
      return .dictionary(object)
    case is [Any]:
      let object = object as? [Any] ?? []
      return .array(object)
    case is String:
      let object = object as? String ?? ""
      return object.starts(with: "http")
        || object.contains("www.")
        || object.contains(".com")
        ? .url(object)
        : .string(object)
    case is Bool:
      let object = object as? Bool ?? false
      return .bool(object)
    case is NSNull:
      let object = object as? NSNull ?? NSNull()
      return .null(object)
    case is NSNumber:
      let object = object as? NSNumber ?? 0
      return .number(object)
    default:
      return .string(object as? String ?? "")
    }
  }
}

