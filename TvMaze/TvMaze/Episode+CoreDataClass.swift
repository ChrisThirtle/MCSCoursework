//
//  Episode+CoreDataClass.swift
//  TvMaze
//
//  Created by Consultant on 6/30/19.
//  Copyright © 2019 Consultant. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Episode)
public class Episode: NSManagedObject, Decodable {
  
  enum CodingKeys: String, CodingKey {
    case name
    case episodeNumber = "number"
    case season
    case airdate
    case summary
    case image
  }
  
  required public init(from decoder: Decoder) throws {
    let context = CoreDataManager.shared.context
    guard let entityDescription = NSEntityDescription.entity(forEntityName: "Episode", in: context) else {
      fatalError("Failed to decode episode")
    }
    super.init(entity: entityDescription, insertInto: context)
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.name = try container.decode(String.self, forKey: .name)
    self.episodeNumber = try container.decode(Int16.self, forKey: .episodeNumber)
    self.season = try container.decode(Int16.self, forKey: .season)
    self.airdate = try container.decode(String.self, forKey: .airdate)
    self.image = try container.decode(ShowImage?.self, forKey: .image)
    
    let summaryHTML: String? = try container.decode(String?.self, forKey: .summary)
    self.summary = summaryHTML?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) ?? ""
  }

}
