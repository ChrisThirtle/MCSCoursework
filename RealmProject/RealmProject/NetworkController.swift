//
//  NetworkController.swift
//  RealmProject
//
//  Created by Consultant on 7/9/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation

protocol NetworkProtocol {
  func getData(for url: String, completion: @escaping (Data?, Error?) -> Void)
}

class NetworkController: NetworkProtocol {
  func getData(for urlString: String, completion: @escaping (Data?, Error?) -> Void) {
    guard let url = URL(string: urlString) else {
      completion(nil, NetworkError.invalidURL)
      return
    }
    URLSession.shared.dataTask(with: url) { (data, _, error) in
      completion(data, error)
    }.resume()
  }
}

enum NetworkError: Error {
  case invalidURL
}
