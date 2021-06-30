//
//  ToDoViewModel.swift
//  MobileApp
//
//  Created by Grzegorz Gumieniak on 17/06/2021.
//

import Foundation

class ToDoListViewModel: ObservableObject {
    let networking = Networking()
    @Published var lists  = [ListContent]()
    @Published var toDoListName: String = ""
    
    func downloadData() {
        networking.fetchData(at: .listContent, with: { data in
            do {
                let serverList = try JSONDecoder().decode([ListContent].self, from: data)
                DispatchQueue.main.async {
                    self.lists = serverList
                }
            }
        })
    }
        
    func addToList() {
        if toDoListName != "" {
            let newToDoList = ListContent(id: 0, name: toDoListName, contents: [Content]())
            lists.append(newToDoList)
            toDoListName = ""
            do {
            let data = try JSONEncoder().encode(newToDoList)
            self.networking.sendData(at: .listContentAdd, with: data    )
            } catch {
                // Show alert that ToDoList aren't send succesfully
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.downloadData()
            })
        }
    }
    
    func deleteList(at index: IndexSet) {
        guard let indexId = index.first else {
            return
        }
        let id = self.lists[indexId].id
        self.lists.remove(atOffsets: index)
        self.networking.deleteData(at: .deleteListContent(id: id))
    }
}
