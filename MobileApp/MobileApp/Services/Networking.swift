//
//  Networking.swift
//  MobileApp
//
//  Created by Grzegorz Gumieniak on 23/06/2021.
//

import Foundation

class Networking {
    
    enum QueryPoint {
        case budget, budgetAdd(id: Int), budgetID(id: Int), budgetType(id: Int), content(listContent: Int),contentAdd(listId: Int),listContent, listContentAdd, deleteBudget(id: Int), deleteContent(id: Int), deleteListContent(id: Int)
    }
    
    func fetchData(at queryPoint: QueryPoint, with: @escaping (Data) throws ->()){
        let request = prepareRequest(to: queryPoint)
        URLSession.shared.dataTask(with: request) { data,_,error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {
                print(NetworkingError.dataWereNotAssigned)
                return
            }
            do {
                try with(data)
            } catch {
                print(NetworkingError.errorWhenDecoding)
            }
            
        }.resume()
    }
    
    func sendData(at queryPoint: QueryPoint,with json: Data) {
        var request = prepareRequest(to: queryPoint)
        let data = json
        request.httpBody = data
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func deleteData(at queryPoint: QueryPoint) {
        let request = prepareRequest(to: queryPoint)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let response = response {
                print(response)
            }
        }.resume()
    }
    
    private func prepareRequest(to queryPoint: QueryPoint) -> URLRequest {
        var request = URLRequest(url: getUrlQuery(from: queryPoint))
        let method = getTypeOfHttpMethod(from: queryPoint)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private func getUrlQuery(from point: QueryPoint) -> URL {
        var url: URL?
        switch point {
        case .budget:
            url = URL(string: Keys.BackendMarcin.budget)
        case .budgetAdd(let id):
            url = URL(string: "\(Keys.BackendMarcin.budgetAdd)/\(id)")
        case .budgetID(let id):
            url = URL(string: "\(Keys.BackendMarcin.budgetID)/\(id)")
        case .budgetType(let id):
            url = URL(string: "\(Keys.BackendMarcin.budgetType)/\(id)")
        case .content(let listCotent):
            url = URL(string: "\(Keys.BackendMarcin.content)/\(listCotent)")
        case .listContent:
            url = URL(string: Keys.BackendMarcin.listContent)
        case .listContentAdd:
            url = URL(string: Keys.BackendMarcin.listContentAdd)
        case .deleteBudget(id: let id):
            url = URL(string: "\(Keys.BackendMarcin.budget)/\(id)")
        case .deleteListContent(id: let id):
            url = URL(string: "\(Keys.BackendMarcin.listContent)/\(id)")
        case .contentAdd(listId: let listId):
            url = URL(string: "\(Keys.BackendMarcin.contentAdd)/\(listId)")
        case .deleteContent(id: let id):
            url = URL(string: "\(Keys.BackendMarcin.contentDelete)/\(id)")
        }
        return url!
    }
    
    private func getTypeOfHttpMethod(from endPoint: QueryPoint) -> String {
        switch endPoint {
        case .budgetAdd,.listContentAdd, .contentAdd:
            return HttpRequests.POST.rawValue
        case .budget,.budgetID,.listContent,.budgetType, .content:
            return HttpRequests.GET.rawValue
        case .deleteBudget, .deleteListContent, .deleteContent:
            return HttpRequests.DELETE.rawValue
        }
    }
    
    private enum HttpRequests: String {
        case POST, GET, DELETE
    }
    
    private enum NetworkingError: Error {
        case dataWereNotAssigned
        case errorWhenDecoding
    }

}
