//
//  Episode+CoreDataClass.swift
//  TvMaze
//
//  Created by Consultant on 7/2/19.
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
  
  public required convenience init(from decoder: Decoder) throws {
    guard let entity = NSEntityDescription.entity(forEntityName: "Episode", in: CoreDataManager.shared.context) else {
      fatalError("Could not decode Episode from Core Data")
    }
    self.init(entity: entity, insertInto: nil)
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.name = try container.decode(String.self, forKey: .name)
    self.episodeNumber = try container.decode(Int16.self, forKey: .episodeNumber)
    self.season = try container.decode(Int16.self, forKey: .season)
    self.airdate = try container.decode(String.self, forKey: .airdate)
    self.image = try container.decode(ShowImage?.self, forKey: .image)
    
    let summaryHTML: String? = try container.decode(String?.self, forKey: .summary)
    self.summary = summaryHTML?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) ?? "No episode summary"
  }
  
  static func ==(lhs: Episode, rhs: Episode) -> Bool {
    return lhs.name == rhs.name
  }
}
