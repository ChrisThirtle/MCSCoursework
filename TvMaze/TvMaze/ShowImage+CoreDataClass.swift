//
//  ShowImage+CoreDataClass.swift
//  TvMaze
//
//  Created by Consultant on 7/2/19.
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
  
  public required convenience init(from decoder: Decoder) throws {
    guard let entity = NSEntityDescription.entity(forEntityName: "ShowImage", in: CoreDataManager.shared.context) else {
      fatalError("Could not decode ShowImage from core data")
    }
    self.init(entity: entity, insertInto: nil)
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.mediumString = try container.decode(String.self, forKey: .mediumString)
    self.originalString = try container.decode(String.self, forKey: .originalString)
  }
}
