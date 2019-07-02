//
//  CoreMemoryController.swift
//  TvMaze
//
//  Created by Consultant on 6/30/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation
import CoreData


class CoreDataManager {
  static let shared = CoreDataManager()
  private init() { }
  
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "FavoriteEpisodeContainer")
    container.loadPersistentStores(completionHandler: { (description, error) in
      return
    })
    return container
  }()
  
  var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  func getFavorites() -> [Episode] {
    let fetchRequest: NSFetchRequest<Episode> = Episode.fetchRequest()
    do {
      let episodeArray: [Episode] = try context.fetch(fetchRequest)
      return episodeArray
    } catch {
      print(error.localizedDescription)
      return []
    }
  }
  
  func addFavorite(episode: Episode) -> Episode? {
    if getFavorites().contains(where:{ episode == $0 }) {
      return nil
    }
    guard let entity = NSEntityDescription.entity(forEntityName: "Episode", in: context) else {
      return nil
    }
    let favorite = Episode(entity: entity, insertInto: context)
    favorite.name = episode.name
    favorite.season = Int16(episode.season)
    favorite.episodeNumber = Int16(episode.episodeNumber)
    favorite.airdate = episode.airdate
    favorite.summary = episode.summary
    return favorite
  }
  
  func removeFavorite(favorite: Episode) {
    context.delete(favorite)
  }
  
}
