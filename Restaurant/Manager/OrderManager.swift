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
    
    static func addOrderItem(orderItem: OrderItem) {
        if self.shared.order.orderItems.count > 0 {
            for i in 0 ..< self.shared.order.orderItems.count {
                if self.shared.order.orderItems[i].id == orderItem.id {
                    self.shared.order.orderItems[i].count += 1
                    return
                }
            }
        }
        self.shared.order.orderItems.append(orderItem)
    }
    
    static func removeItem(at index: Int) {
        let count = shared.order.orderItems[index].count
        if count > 1 {
            shared.order.orderItems[index].count -= 1
        } else {
            shared.order.orderItems.remove(at: index)
        }
    }
}
