//
//  URL+Extension.swift
//  Restaurant
//
//  Created by Konstantin Ryabtsev on 01.03.2022.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        return components?.url
    }
    
    
}
