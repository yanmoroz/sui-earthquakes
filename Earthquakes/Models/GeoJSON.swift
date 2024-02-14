//
//  GeoJSON.swift
//  Earthquakes
//
//  Created by Yan Moroz on 14.02.2024.
//

import Foundation

struct GeoJSON: Decodable {
    
    private enum RootCodingKeys: String, CodingKey {
        case features
    }
    
    private enum FeaturedCodingKeys: String, CodingKey {
        case properties
    }
    
    private(set) var quakes = [Quake]()
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        var featuredContainer = try rootContainer.nestedUnkeyedContainer(forKey: .features)
        
        while !featuredContainer.isAtEnd {
            let propertiesContainer = try featuredContainer.nestedContainer(keyedBy: FeaturedCodingKeys.self)
            if let properties = try? propertiesContainer.decode(Quake.self, forKey: .properties) {
                quakes.append(properties)
            }
        }
    }
}
