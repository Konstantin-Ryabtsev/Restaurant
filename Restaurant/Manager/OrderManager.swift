//
//  OrderManager.swift
//  Restaurant
//
//  Created by Konstantin Ryabtsev on 08.03.2022.
//

import Foundation

class OrderManager {
    static let orderUpdatedNotification = Notification.Name("OrderManager.orderUpdated")
    
    static var shared = OrderManager()
    
    private init() {}
    
    var order = Order() {
        didSet {
            NotificationCenter.default.post(name: OrderManager.orderUpdatedNotification, object: nil)
        }
    }
}
