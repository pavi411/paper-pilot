//
//  DataManger.swift
//  mmdb
//
//  Created by Pavithra Sridhar on 5/28/24.
//

import CoreData
import Foundation

class DataManager: ObservableObject {
  let container = NSPersistentContainer(name: "Paperdb")

  static let shared = DataManager()

  private init() {
    container.loadPersistentStores { description, error in
      if let error = error {
        print("Core Data failed to load: \(error.localizedDescription)")
      }
    }
  }
}
