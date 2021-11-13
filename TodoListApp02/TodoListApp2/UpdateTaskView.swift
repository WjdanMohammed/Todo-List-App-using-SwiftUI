//
//  UpdateTaskView.swift
//  TodoListApp2
//
//  Created by WjdanMo on 08/11/2021.
//

import SwiftUI

struct UpdateTaskView: View {
    var task : Task?
    
    @State var name : String = ""
    @State var desc : String = ""
    @State var isChecked : Bool = false
    
    @Environment(\.presentationMode) var presentaionMode
    
    @Environment(\.managedObjectContext) private var viewContect
    
    init(task : Task? = nil){
        self.task = task
        _name = State(initialValue: task?.name ?? "")
        _desc = State(initialValue: task?.desc ?? "")
        _isChecked = State(initialValue: task?.isChecked ?? false)
        
    }
    
    var body: some View {
        
        NavigationView{
            VStack(alignment: .center){
                HStack{
                    VStack{
                        TextField(text: $name) {
                            Text("new task name")
                        }
                        TextField(text: $desc) {
                            Text("new task description")
                        }
                    }
                    
                    Spacer(minLength: 20)
                    Toggle(isOn: $isChecked) {}.labelsHidden()
                }
                
                Spacer(minLength: 40)
                Button{
                    
                    do {
                        if let task = task {
                            task.name = name
                            task.desc = desc
                            task.isChecked = isChecked
                            try viewContect.save()
                        }
                    }
                    catch{
                        let nserror = error as NSError
                        fatalError("Failed to save changes \(nserror)")
                    }
                    
                    presentaionMode.wrappedValue.dismiss()
                }label: {
                    Text("Save").bold()
                }
                .foregroundColor(.white)
                .frame(maxWidth : .infinity)
                .frame(width: 120, height: 40)
                .background(Color(#colorLiteral(red: 1, green: 0.4532907009, blue: 0, alpha: 1)))
                .cornerRadius(15)
                .buttonStyle(.borderless)
                
            }.padding(20)
                .frame(width: 340, height: 200, alignment: .center)
        }.preferredColorScheme(.dark)
    }
}

struct UpdateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateTaskView()
    }
}

