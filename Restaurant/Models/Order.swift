//
//  Order.swift
//  Restaurant
//
//  Created by Konstantin Ryabtsev on 08.03.2022.
//

import Foundation

struct Order {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
