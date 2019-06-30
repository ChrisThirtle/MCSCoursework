//
//  Show+CoreDataClass.swift
//  TvMaze
//
//  Created by Consultant on 6/30/19.
//  Copyright © 2019 Consultant. All rights reserved.
//
//

import Foundation

class Show: Decodable {
  
  let name: String
  let episodes: [Episode]
  let image: ShowImage?

  
  enum CodingKeys: String, CodingKey {
    case name
    case image
    case embed = "_embedded"
    case episodes
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.name = try container.decode(String.self, forKey: .name)
    self.image = try container.decode(ShowImage.self, forKey: .image)
    
    let embedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .embed)
    self.episodes = try embedContainer.decode([Episode].self, forKey: .episodes)
    
  }
}
