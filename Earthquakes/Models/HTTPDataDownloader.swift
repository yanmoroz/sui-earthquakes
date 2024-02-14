//
//  HTTPDataDownloader.swift
//  Earthquakes
//
//  Created by Yan Moroz on 14.02.2024.
//

import Foundation

let validStatus = 200...299

protocol HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data
}

extension URLSession: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        let dataAndResponse = try await self.data(from: url, delegate: nil) as? (Data, HTTPURLResponse)
        guard let (data, _) = dataAndResponse else {
            throw QuakeError.networkError
        }
        return data
    }
}

