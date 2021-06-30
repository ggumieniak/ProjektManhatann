//
//  ContentView.swift
//  MobileApp
//
//  Created by Grzegorz Gumieniak on 01/06/2021.
//

import SwiftUI

struct MainView: View {
    // TODO: Create the separaste views for every functionality each
    // TODO: When the view appear in my opinnion we should download data, not before. Without listener at the base only with change smt at state will refresh the data of app.
    var body: some View {
        TabView {
            Text("Hello, world!")
                .tabItem {
                    Image(systemName: "dollarsign.circle")
                    Text("Finance")
                }
            ToDoListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("ToDo")
                }
            WeatherView()
                .tabItem {
                    Image(systemName: "cloud")
                    Text("Weather")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
