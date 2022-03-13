//
//  PreparationTime.swift
//  Restaurant
//
//  Created by Konstantin Ryabtsev on 08.03.2022.
//

import Foundation

struct PreparationTime: Codable {
    let preparationTime: Int
    
    enum CodingKeys: String, CodingKey {
        case preparationTime = "preparation_time"
    }
}
