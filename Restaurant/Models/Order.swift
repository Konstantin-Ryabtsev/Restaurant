//
//  Order.swift
//  Restaurant
//
//  Created by Konstantin Ryabtsev on 08.03.2022.
//

import Foundation

struct Order {
    var orderItems: [OrderItem]
    
    init(orderItems: [OrderItem] = []) {
        self.orderItems = orderItems
    }
}
