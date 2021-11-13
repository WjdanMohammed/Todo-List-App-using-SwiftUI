//
//  ContentView.swift
//  TodoListApp2
//
//  Created by WjdanMo on 08/11/2021.
//

import SwiftUI

struct ContentView: View {

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: false)], animation: .default)

    private var myTask : FetchedResults<Task>

    @State var name : String = ""
    @State var desc : String = ""
    @State var isChecked : Bool = false
    @State var timestamp = Date()

    var body: some View {

        NavigationView{
            VStack{
                TextField("Name", text: $name).padding(.horizontal)
                TextField("Description", text: $desc).padding(.horizontal)

                Button{
                    do {
                        let task = Task(context: viewContext)
                        task.name = name
                        task.desc = desc
                        task.isChecked = isChecked
                        task.timestamp = timestamp
                        try viewContext.save()
                    }

                    catch {}

                } label: {
                    Text("Add task").bold()
                        .foregroundColor(.white)
                        .frame(maxWidth : .infinity)
                        .frame(height: 40)
                        .background(Color(#colorLiteral(red: 1, green: 0.4532907009, blue: 0, alpha: 1)))
                        .cornerRadius(10)
                        .buttonStyle(.borderless)

                }.padding()

                List{
                    if myTask.isEmpty {
                        Text("ur to-do list is empty :) ")
                            .foregroundColor(.gray)
                    }
                    else{
                        ForEach(myTask) { task in
                            NavigationLink {
                                UpdateTaskView(task: task)
                            } label: {
                                HStack{
                                    VStack(alignment: .leading ){
                                        Text(task.name ?? "")
                                        Text(task.desc ?? "").font( .footnote)
                                    }
                                    Spacer()
                                    Button{
                                        task.isChecked = !task.isChecked
                                        do {
                                            try viewContext.save()
                                        }
                                        catch{}

                                    } label:{
                                        Image(systemName: task.isChecked ? "checkmark" : "nil" )
                                    }.buttonStyle(.borderless)
                                }
                            }
                            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                Button{
                                    if let deletedTask = myTask.firstIndex(of: task){
                                        viewContext.delete(myTask[deletedTask])
                                        do {
                                            try viewContext.save()
                                        }
                                        catch {}
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                }.tint(.red)
                            }
                        }
                    }
                }
            }.navigationTitle("To-Do list :")
        }
        .preferredColorScheme(.dark)
        .navigationBarTitleDisplayMode(.large)
        .padding(20)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


