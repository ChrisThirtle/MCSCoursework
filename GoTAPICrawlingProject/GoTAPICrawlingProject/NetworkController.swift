//
//  NetworkController.swift
//  GoTAPICrawlingProject
//
//  Created by Consultant on 7/2/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation

protocol NetworkProtocol {
  func getData(url: URL, completion: @escaping (Data?, Error?) -> Void)
}

class NetworkController: NetworkProtocol {
  func getData(url: URL, completion: @escaping (Data?, Error?) -> Void) {
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      completion(data, error)
    }.resume()
  }
}
