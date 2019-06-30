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
    let container = NSPersistentContainer(name: "ShowContainer")
    container.loadPersistentStores(completionHandler: { (description, error) in
      print(description)
      print(error)
    })
    return container
  }()
  
  var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  func getAllEpisodes() -> [Episode] {
    let fetchRequest: NSFetchRequest<Episode> = Episode.fetchRequest()
    do {
      let episodeArray: [Episode] = try context.fetch(fetchRequest)
      return episodeArray
    } catch {
      print(error.localizedDescription)
      return []
    }
  }
  
}
