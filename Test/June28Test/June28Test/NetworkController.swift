//
//  NetworkController.swift
//  June28Test
//
//  Created by Consultant on 6/28/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation

protocol NetworkProtocol {
  func fetchData(url: String, completionHandler: @escaping (Data?, Error?) -> Void)
}

struct NetworkController: NetworkProtocol {
  func fetchData(url: String, completionHandler: @escaping (Data?, Error?) -> Void) {
    guard let url = URL(string: url) else {
      return
    }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      completionHandler(data, error)
    }.resume()
  }
}
