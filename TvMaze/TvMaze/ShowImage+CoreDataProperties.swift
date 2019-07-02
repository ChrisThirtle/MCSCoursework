//
//  ShowImage+CoreDataProperties.swift
//  TvMaze
//
//  Created by Consultant on 7/2/19.
//  Copyright © 2019 Consultant. All rights reserved.
//
//

import Foundation
import CoreData


extension ShowImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShowImage> {
        return NSFetchRequest<ShowImage>(entityName: "ShowImage")
    }

    @NSManaged public var mediumString: String?
    @NSManaged public var originalString: String?

}
