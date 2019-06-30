//
//  ShowController.swift
//  TvMaze
//
//  Created by Consultant on 6/26/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class ShowController {
  
  var show: Show?
  
  let networkController: NetworkProtocol
  init(networkController: NetworkProtocol = NetworkController()) {
    self.networkController = networkController
  }
  //CRUD functionality
  //Create, Read, Update, Delete
  
  func getShow(urlString: String, completionHandler: @escaping (Show?) -> Void) {
    networkController.fetchData(from: urlString) { (data, error) in
      if error != nil {
        return
      }
      guard let data = data,
        let show = try? JSONDecoder().decode(Show.self, from: data)
        else {
          return
      }
      completionHandler(show)
    }
  }
  
  func sortShowBySeasons(show: Show) -> [[Episode]] {
    let sorted = show.episodes.sorted { (e1, e2) -> Bool in
      if e1.season == e2.season {
        return e1.episodeNumber <= e2.episodeNumber
      }
      else {
        return e1.season <= e2.season
      }
    }
    
    guard let lastEp = sorted.last else {
      return []
    }
    var seasons = [[Episode]](repeating: [], count: Int(lastEp.season))
    for episode in sorted {
      seasons[Int(episode.season) - 1].append(episode)
    }
    return seasons
  }
  
  func getImage( networkController: NetworkProtocol = NetworkController(),
                 imageString: String,
                 completionHandler: @escaping (UIImage?, Error?) -> Void ) {
    
    networkController.fetchData(from: imageString) { (data, error) in
      guard let data = data,
        let image = UIImage(data: data) else {
          completionHandler(nil, error)
          return
      }
      completionHandler(image, error)
    }
  }
}
