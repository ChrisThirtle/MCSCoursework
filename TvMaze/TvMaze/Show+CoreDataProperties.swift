//
//  Show+CoreDataProperties.swift
//  TvMaze
//
//  Created by Consultant on 6/30/19.
//  Copyright © 2019 Consultant. All rights reserved.
//
//

import Foundation
import CoreData


extension Show {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Show> {
        return NSFetchRequest<Show>(entityName: "Show")
    }
  
    @NSManaged public var name: String
    @NSManaged public var episodes: Set<Episode>
    @NSManaged public var image: ShowImage?

}

// MARK: Generated accessors for episodes
extension Show {

    @objc(addEpisodesObject:)
    @NSManaged public func addToEpisodes(_ value: Episode)

    @objc(removeEpisodesObject:)
    @NSManaged public func removeFromEpisodes(_ value: Episode)

    @objc(addEpisodes:)
    @NSManaged public func addToEpisodes(_ values: NSSet)

    @objc(removeEpisodes:)
    @NSManaged public func removeFromEpisodes(_ values: NSSet)

}
