//
//  QuakeClient.swift
//  Earthquakes
//
//  Created by Yan Moroz on 14.02.2024.
//

import Foundation

final class QuakeClient {
    
    private let feedURL = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson")!
    private let downloader: any HTTPDataDownloader
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        return decoder
    }()
    
    var quakes: [Quake] {
        get async throws {
            let data = try await downloader.httpData(from: feedURL)
            let json = try decoder.decode(GeoJSON.self, from: data)
            return json.quakes
        }
    }
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
}
