//
//  URLs.swift
//  Foodics
//
//  Created by Ahmed Elmemy on 20/02/2021.
//


import Foundation

struct URLs {
    
    //Base URL
    static let BASE = "https://api.foodics.dev/v5/"
    static let Google_GeoCoding = "https://maps.googleapis.com/maps/api/geocode/json?latlng="
    
    
    static let categories             = BASE + "categories"
    static let products               = BASE + "products?include=category"

}
