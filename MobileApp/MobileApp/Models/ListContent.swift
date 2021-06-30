//
//  ListContent.swift
//  MobileApp
//
//  Created by Grzegorz Gumieniak on 17/06/2021.
//

import Foundation


struct ListContent: Codable, Identifiable {
    var id: Int
    var name: String
    var contents: [Content]
}
