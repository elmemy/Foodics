//
//  ProductModel.swift
//  Foodics
//
//  Created by Ahmed Elmemy on 20/02/2021.
//

import Foundation
import RealmSwift

class ProductModel: Object,Codable {
    
    @objc dynamic var category: Category?
    @objc dynamic var id, sku: String
    @objc dynamic var name: String
    @objc dynamic var image: String?
    @objc dynamic var price: Double
    

}
