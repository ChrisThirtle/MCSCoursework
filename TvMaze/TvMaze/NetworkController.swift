//
//  NetworkController.swift
//  TvMaze
//
//  Created by Consultant on 6/26/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation

class NetworkController: NetworkProtocol {
  
  func fetchData(from url:String, completionHandler: @escaping (Data?, Error?) -> Void) {
    guard let url = URL(string: url) else{
      return
    }
    URLSession.shared.dataTask(with: url) {
      (data, response, error) in
      completionHandler(data, error)
    }.resume()
  }
}

protocol NetworkProtocol {
  func fetchData(from url: String, completionHandler: @escaping (Data?, Error?) -> Void)
}
