//
//  RealmController.swift
//  RealmProject
//
//  Created by Consultant on 7/10/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation
import RealmSwift

class RealmController {
  static let shared = RealmController()
  private let workingThread = DispatchQueue(label: "RealmQueue", qos: .default)
  private var realm: Realm? {
    do {
      return try Realm()
    }
    catch {
      print("Could not initialize realm database", error)
    }
    return nil
  }
  
  private init() { }
  
  func addToRealm(_ object: Object) {
    if object.realm == nil {
      workingThread.async {
        autoreleasepool {
          guard let realm = self.realm else { return }
          try? realm.write {
            realm.add(object)
          }
        }
      }
    }
    else {
      let objectRef = ThreadSafeReference(to: object)
      workingThread.async {
        autoreleasepool {
          guard let realm = self.realm,
            let object = realm.resolve(objectRef)
            else { return }
          try? realm.write {
            realm.add(object)
          }
        }
      }
    }
  }
  
  func getFromRealm(objectType: Object.Type) -> [Object] {
    var resultsRef: ThreadSafeReference<Results<Object>>?
    workingThread.sync {
      autoreleasepool {
        guard let realm = realm else { return }
        resultsRef = ThreadSafeReference(to: realm.objects(objectType))
      }
    }
    guard let resultsRefUnwrapped = resultsRef,
      let results = self.realm?.resolve(resultsRefUnwrapped)
      else { return [] }
    return Array(results)
  }
}
