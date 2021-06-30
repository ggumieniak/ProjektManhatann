//
//  Keys.swift
//  MobileApp
//
//  Created by Grzegorz Gumieniak on 23/06/2021.
//

import Foundation

struct Keys {
    struct OpewWeather {
        static let ApiKey = "7e61fbf284a02accf727a737a9c7626a"
        static let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric"
    }
    struct BackendMarcin {
        static let budget = "http://budgetwebapi.herokuapp.com/api/budget"
        static let budgetAdd = "http://budgetwebapi.herokuapp.com/api/budget/add"
        static let budgetID = "http://budgetwebapi.herokuapp.com/api/budget/"
        static let budgetType = "http://budgetwebapi.herokuapp.com/api/budget/type/"
        static let contentAdd = "http://budgetwebapi.herokuapp.com/api/content/add"
        static let content = "http://budgetwebapi.herokuapp.com/api/listContent/contents"
        static let contentDelete = "http://budgetwebapi.herokuapp.com/api/content"
        static let listContent = "http://budgetwebapi.herokuapp.com/api/listContent"
        static let listContentAdd = "http://budgetwebapi.herokuapp.com/api/listContent/add"
    }
}
face
