//
//  CoreDataManager.swift
//  TodoListApp2
//
//  Created by WjdanMo on 08/11/2021.
//

import CoreData

class CoreDataManager{
    let persistentContainer : NSPersistentContainer
    static let shared : CoreDataManager = CoreDataManager()
    
    private init (){
        persistentContainer = NSPersistentContainer(name: "TaskDatabase")
        persistentContainer.loadPersistentStores { description , error in
            if let error = error {
                fatalError("unable to load data \(error.localizedDescription)")
            }
        }
    }
}
