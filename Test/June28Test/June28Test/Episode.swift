//
//  Episode.swift
//  June28Test
//
//  Created by Consultant on 6/28/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

/*
 episode title
 Premier date
 Airtime
 Season
 episode number
 summary
 */

import Foundation

class Episode: Decodable {
  let name: String
  let airdate: String
  let airtime: String
  let season: Int
  let episodeNumber: Int
  let summary: String?
  let image: ShowImage?
  
  enum CodingKeys: String, CodingKey {
    case name, airdate, season, airtime, summary, image
    case episodeNumber = "number"
  }
}
