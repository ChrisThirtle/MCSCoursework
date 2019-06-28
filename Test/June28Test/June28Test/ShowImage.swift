//
//  ShowImage.swift
//  June28Test
//
//  Created by Consultant on 6/28/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation

class ShowImage: Decodable {
  let mediumString: String?
  let originalString: String?
  
  enum CodingKeys: String, CodingKey {
    case mediumString = "medium"
    case originalString = "original"
  }
}
