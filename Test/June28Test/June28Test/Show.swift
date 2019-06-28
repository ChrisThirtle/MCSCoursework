//
//  Show.swift
//  June28Test
//
//  Created by Consultant on 6/28/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation


class Show: Decodable {
  let name: String
  let episodes: [Episode]
  
  enum CodingKeys: String, CodingKey {
    case name
    case embed = "_embedded"
    case episodes
  }
  
  init() {
    self.name = ""
    self.episodes = []
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.name = try container.decode(String.self, forKey: .name)
    let embedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .embed)
    self.episodes = try embedContainer.decode([Episode].self, forKey: .episodes)
  }
}
