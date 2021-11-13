//
//  TodoListApp2App.swift
//  TodoListApp2
//
//  Created by WjdanMo on 08/11/2021.
//

import SwiftUI

@main
struct TodoListApp2App: App {
    
    let persistantContainer = CoreDataManager.shared.persistentContainer

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistantContainer.viewContext)
        }
    }
}
