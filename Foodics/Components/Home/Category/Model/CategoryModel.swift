//
//  Category.swift
//  Foodics
//
//  Created by Ahmed Elmemy on 20/02/2021.
//

import Foundation
import RealmSwift

// MARK: - CategoryModel
class CategoryModel:Codable{
    var data: [Category]
    var links: Links
    var meta: Meta
}

// MARK: - category
class Category: Object,Codable {
    @objc dynamic var id, name: String
    @objc dynamic var nameLocalized: String?
    @objc dynamic var reference: String?
    @objc dynamic var image: String?
    @objc dynamic var createdAt: String?
    @objc dynamic var updatedAt: String?
    @objc dynamic var deletedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case nameLocalized = "name_localized"
        case reference, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
    

}






// MARK: - Links
struct Links: Codable {
    let first, last: String
    let prev: String?
    let next: String
}

// MARK: - Meta
struct Meta: Codable {
    let currentPage, from, lastPage: Int
    let path: String
    let perPage, to, total: Int
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case from
        case lastPage = "last_page"
        case path
        case perPage = "per_page"
        case to, total
    }
}


