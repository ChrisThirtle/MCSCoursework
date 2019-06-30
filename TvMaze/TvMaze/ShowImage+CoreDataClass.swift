//
//  ShowImage+CoreDataClass.swift
//  TvMaze
//
//  Created by Consultant on 6/30/19.
//  Copyright © 2019 Consultant. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ShowImage)
public class ShowImage: NSManagedObject, Decodable {
  enum CodingKeys: String, CodingKey {
    case mediumString = "medium"
    case originalString = "original"
  }
  
  required public init(from decoder: Decoder) throws {
    let context = CoreDataManager.shared.context
    guard let entityDescription = NSEntityDescription.entity(forEntityName: "ShowImage", in: context) else {
      fatalError("Failed to decode image")
    }
    super.init(entity: entityDescription, insertInto: context)
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.mediumString = try container.decode(String.self, forKey: .mediumString)
    self.originalString = try container.decode(String.self, forKey: .originalString)
  }
}
