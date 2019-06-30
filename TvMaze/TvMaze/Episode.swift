//
//  Episode+CoreDataClass.swift
//  TvMaze
//
//  Created by Consultant on 6/30/19.
//  Copyright © 2019 Consultant. All rights reserved.
//
//

import Foundation

class Episode: Decodable {
  
  let name: String
  let season: Int
  let episodeNumber: Int
  let airdate: String
  let summary: String?
  let image: ShowImage?
  
  enum CodingKeys: String, CodingKey {
    case name
    case episodeNumber = "number"
    case season
    case airdate
    case summary
    case image
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.name = try container.decode(String.self, forKey: .name)
    self.episodeNumber = try container.decode(Int.self, forKey: .episodeNumber)
    self.season = try container.decode(Int.self, forKey: .season)
    self.airdate = try container.decode(String.self, forKey: .airdate)
    self.image = try container.decode(ShowImage?.self, forKey: .image)
    
    let summaryHTML: String? = try container.decode(String?.self, forKey: .summary)
    self.summary = summaryHTML?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) ?? ""
  }
  
  init(from favorite: FavoriteEpisode) {
    self.name = favorite.name ?? ""
    self.episodeNumber = Int(favorite.episodeNumber)
    self.season = Int(favorite.season)
    self.airdate = favorite.airdate ?? ""
    self.summary = favorite.summary
    self.image = nil
  }
  
  static func ==(lhs: Episode, rhs: Episode) -> Bool {
    return lhs.name == rhs.name
  }
}
