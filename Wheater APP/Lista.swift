//  Lista.swift
//  Wheater APP
//  Created by Jianji Zhong Huang on 7/10/24.
import Foundation

struct ListCities: Codable{
    var city: [String]
    
    func json() throws -> Data {
        let encoded = try JSONEncoder().encode(self)
        return encoded
    }
    
    init (json: Data) throws {
        self = try JSONDecoder().decode(ListCities.self, from: json)
    }
    
    init(city: [String]) {
        self.city = city
    }
}
