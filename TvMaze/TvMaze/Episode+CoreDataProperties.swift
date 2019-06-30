//
//  Episode+CoreDataProperties.swift
//  TvMaze
//
//  Created by Consultant on 6/30/19.
//  Copyright © 2019 Consultant. All rights reserved.
//
//

import Foundation
import CoreData


extension Episode {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Episode> {
        return NSFetchRequest<Episode>(entityName: "Episode")
    }

    @NSManaged public var name: String
    @NSManaged public var season: Int16
    @NSManaged public var episodeNumber: Int16
    @NSManaged public var airdate: String
    @NSManaged public var summary: String?
    @NSManaged public var image: ShowImage?

}
