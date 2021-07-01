//
//  NetworkTests.swift
//  MobileAppTests
//
//  Created by Grzegorz Gumieniak on 24/06/2021.
//

import XCTest
@testable import ProjektManhatann

class NetworkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testFetchDataAtListContent() {
        let networking = Networking()
        var toDoList: [ListContent] = [ListContent]()
        networking.fetchData(at: .listContent, with: { data in
            let json = try JSONDecoder().decode([ListContent].self, from: data)
            print(json)
            DispatchQueue.main.async {
                toDoList = json
            }
        })
        
    }
    
    func testSendDataAtListContent() {
        let networking = Networking()
        let sendItem = ListContent(id: 0, name: "Druga", contents: [Content(id: 0, description: "Mleko"),Content(id: 0, description: "Kanapki"),Content(id: 0, description: "Zmienić prace")])
        do {
            let json = try JSONEncoder().encode(sendItem)
            networking.sendData(at: .listContentAdd, with: json)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
