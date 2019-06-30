//
//  ShowImage+CoreDataClass.swift
//  TvMaze
//
//  Created by Consultant on 6/30/19.
//  Copyright © 2019 Consultant. All rights reserved.
//
//

import Foundation

public class ShowImage: Decodable {
  
  let mediumString: String?
  let originalString: String?
  
  enum CodingKeys: String, CodingKey {
    case mediumString = "medium"
    case originalString = "original"
  }
  
  required public init(from decoder: Decoder) throws {    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.mediumString = try container.decode(String.self, forKey: .mediumString)
    self.originalString = try container.decode(String.self, forKey: .originalString)
  }
}
