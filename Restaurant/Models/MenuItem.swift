//
//  MenuItem.swift
//  Restaurant
//
//  Created by Konstantin Ryabtsev on 01.03.2022.
//

import Foundation
import CoreText

struct MenuItem: Codable {
    let id: Int
    let name: String
    let detailText: String
    let price: Double
    let category: String
    let imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case detailText = "description"
        case price
        case category
        case imageURL = "image_url"
    }
}
