//
//  Episode.swift
//  TvMaze
//
//  Created by Consultant on 6/26/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation

struct Episode: Decodable {
  let name: String
  let episodeNumber: Int
  let season: Int
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
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.name = try container.decode(String.self, forKey: .name)
    self.episodeNumber = try container.decode(Int.self, forKey: .episodeNumber)
    self.season = try container.decode(Int.self, forKey: .season)
    self.airdate = try container.decode(String.self, forKey: .airdate)
    self.image = try container.decode(ShowImage?.self, forKey: .image)
    
    let summaryHTML: String? = try container.decode(String?.self, forKey: .summary)
    self.summary = summaryHTML?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) ?? ""
  }
}
