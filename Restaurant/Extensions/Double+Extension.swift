//
//  Double+Extension.swift
//  Restaurant
//
//  Created by Konstantin Ryabtsev on 08.03.2022.
//

import Foundation

extension Double {
    var formattedHundreds: String {
        return String(format: "$%.2f", self)
    }
}
