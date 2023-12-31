//
//  CoreDataService.swift
//  TestTranslator
//
//  Created by Vadim on 21.08.23.
//

import Foundation
import CoreData

final class CoreDataService {
    
    static var shared: CoreDataService = CoreDataService()
    
    private init() { }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TestTranslator")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
