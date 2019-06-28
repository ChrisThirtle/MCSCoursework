//
//  EpImage.swift
//  TvMaze
//
//  Created by Consultant on 6/27/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation

struct ShowImage: Decodable {
  let mediumString: String?
  let originalString: String?
  
  enum CodingKeys: String, CodingKey {
    case mediumString = "medium"
    case originalString = "original"
  }
}
