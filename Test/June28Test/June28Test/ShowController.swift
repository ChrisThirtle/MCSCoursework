//
//  ShowController.swift
//  June28Test
//
//  Created by Consultant on 6/28/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation


class ShowController {
  
  func getShow(networkController: NetworkProtocol = NetworkController(),
               url: String,
               completionHandler: @escaping (Show) -> Void) {
    networkController.fetchData(url: url) { (data, error) in
      if error != nil {
        return
      }
      guard let data = data,
        let myShow = try? JSONDecoder().decode(Show.self, from: data) else {
        return
      }

      completionHandler(myShow)
    }
  }
  
  func getImageData(networkController: NetworkProtocol = NetworkController(),
                imageUrl: String,
                completionHandler: @escaping (Data?) -> Void) {
    networkController.fetchData(url: imageUrl) { (data, error) in
      if error != nil {
        return
      }
      completionHandler(data)
    }
  }
  
  func sortEpisodesToSeasons(episodes: [Episode]) -> [[Episode]] {
    let sorted = episodes.sorted { (e1, e2) -> Bool in
      if e1.season == e2.season {
        return e1.episodeNumber <= e2.episodeNumber
      }
      else {
        return e1.season < e2.season
      }
    }
    guard let last = sorted.last else {
      return []
    }
    var season = [[Episode]](repeating: [], count: last.season)
    for episode in sorted {
      season[episode.season - 1].append(episode)
    }
    return season
  }
  
  func stripHtmlFromSummary(summary: String) -> String {
    return summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
  }
}
