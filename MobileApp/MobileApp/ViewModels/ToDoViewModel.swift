//
//  ToDoViewModel.swift
//  MobileApp
//
//  Created by Grzegorz Gumieniak on 17/06/2021.
//

import Foundation

class ToDoViewModel: ObservableObject {
    let networking = Networking()
    @Published var ToDoPoints: [Content]
    let listId: Int
    let title: String
    @Published var ToDoPoint = ""
    
    init(content: [Content], listId: Int, title: String) {
        self.ToDoPoints = content
        self.listId = listId
        self.title = title
    }
    
    func downloadData() {
        networking.fetchData(at: .content(listContent: listId), with: { data in
            do {
                let serverContent = try JSONDecoder().decode([Content].self, from: data)
                DispatchQueue.main.async {
                    self.ToDoPoints = serverContent
                }
            }
        })
    }
    
    func AddToList() {
        if ToDoPoint != "" {
            let ToDo = Content(id: 0, description: ToDoPoint)
            ToDoPoints.append(ToDo)
            do {
            let data = try JSONEncoder().encode(ToDo)
            self.networking.sendData(at: .contentAdd(listId: listId), with: data)
            } catch {
                // Show alert that ToDoList aren't send succesfully
                return
            }
            ToDoPoint = ""
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.downloadData()
            })
        }
    }
    
    func deletePoint(at index: IndexSet) {
        guard let indexId = index.first else {
            return
        }
        let id = self.ToDoPoints[indexId].id
        self.ToDoPoints.remove(atOffsets: index)
        self.networking.deleteData(at: .deleteContent(id: id))
    }
}
