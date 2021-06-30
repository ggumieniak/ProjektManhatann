//
//  ToDoView.swift
//  MobileApp
//
//  Created by Grzegorz Gumieniak on 15/06/2021.
//

import SwiftUI

struct ToDoListView: View {
    
    @StateObject var viewModel: ToDoListViewModel = ToDoListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack {
                    TextField("Add list",text: self.$viewModel.toDoListName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    List {
                        ForEach(self.viewModel.lists) { toDoList in
                            NavigationLink(toDoList.name, destination: ToDoView(content: toDoList.contents, listId: toDoList.id, title: toDoList.name))
                        }.onDelete(perform: { index in
                            self.viewModel.deleteList(at: index)
                        })
                    }
                    .navigationTitle("ToDo")
                }
                HStack {
                    Spacer()
                    Button(action: self.viewModel.addToList, label: {
                        Text("+")
                    })
                    .padding()
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }.onAppear(perform: {
                self.viewModel.downloadData()
            })
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(viewModel: ToDoListViewModel())
    }
}
