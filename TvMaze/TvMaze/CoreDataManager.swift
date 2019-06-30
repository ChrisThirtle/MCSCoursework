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
      print(description)
      print(error)
    })
    return container
  }()
  
  var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  func getFavorites() -> [FavoriteEpisode] {
    let fetchRequest: NSFetchRequest<FavoriteEpisode> = FavoriteEpisode.fetchRequest()
    do {
      let episodeArray: [FavoriteEpisode] = try context.fetch(fetchRequest)
      return episodeArray
    } catch {
      print(error.localizedDescription)
      return []
    }
  }
  
  func addFavorite(episode: Episode) -> FavoriteEpisode? {
    let favorites = getFavorites().map { Episode(from: $0)}
    if favorites.contains(where:{ episode == $0 }) {
      return nil
    }
    guard let entity = NSEntityDescription.entity(forEntityName: "FavoriteEpisode", in: context) else {
      return nil
    }
    let favorite = FavoriteEpisode.init(entity: entity, insertInto: context)
    favorite.name = episode.name
    favorite.season = Int16(episode.season)
    favorite.episodeNumber = Int16(episode.episodeNumber)
    favorite.airdate = episode.airdate
    favorite.summary = episode.summary
    return favorite
  }
  
  func removeFavorite(favorite: FavoriteEpisode) {
    context.delete(favorite)
  }
  
}
