//
//  Show+CoreDataClass.swift
//  TvMaze
//
//  Created by Consultant on 6/30/19.
//  Copyright © 2019 Consultant. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Show)
public class Show: NSManagedObject, Decodable {
  
  enum CodingKeys: String, CodingKey {
    case name
    case image
    case embed = "_embedded"
    case episodes
  }
  
  required public init(from decoder: Decoder) throws {
    let context = CoreDataManager.shared.context
    guard let entityDescription = NSEntityDescription.entity(forEntityName: "Show", in: context) else {
      fatalError("Failed to decode show")
    }
    super.init(entity: entityDescription, insertInto: context)
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.name = try container.decode(String.self, forKey: .name)
    self.image = try container.decode(ShowImage.self, forKey: .image)
    
    let embedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .embed)
    self.episodes = try embedContainer.decode(Set<Episode>.self, forKey: .episodes)
    
  }
}
