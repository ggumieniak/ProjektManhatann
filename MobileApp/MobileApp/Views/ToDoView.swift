//
//  ToDoView.swift
//  MobileApp
//
//  Created by Grzegorz Gumieniak on 17/06/2021.
//

import SwiftUI

struct ToDoView: View {
    @ObservedObject
    var viewModel: ToDoViewModel
    var body: some View {
        VStack {
            VStack {
            TextField("ToDo",text: self.$viewModel.ToDoPoint)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                List {
                    ForEach(self.viewModel.ToDoPoints) { content in
                    Text(content.description)
                    }.onDelete(perform: { indexSet in
                        self.viewModel.deletePoint(at: indexSet)
                    })
                }
                HStack {
                    HStack {
                        Spacer()
                        Button(action: self.viewModel.AddToList, label: {
                            Text("+")
                        })
                        .padding()
                        .background(Color.red)
                        .foregroundColor(Color.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                        .padding(.bottom)
                    }
                }
            }
        }.navigationTitle(self.viewModel.title)
    }
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView(viewModel: ToDoViewModel(content: [Content(id: 0, description: "Mleko"),Content(id: 1, description: "Chleb"),Content(id: 2, description: "Buki")], listId: 0, title: "Preview"))
    }
}


extension ToDoView {
    init(content: [Content], listId: Int, title: String) {
        self.viewModel = ToDoViewModel(content: content, listId: listId,title: title)
    }
}
