//
//  EarthquakesTests.swift
//  EarthquakesTests
//
//  Created by Yan Moroz on 14.02.2024.
//

import XCTest
@testable import Earthquakes

final class EarthquakesTests: XCTestCase {
    
    func testGeoJSONDecoderDecodesQuake() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        let quake = try decoder.decode(Quake.self, from: testFeature_nc73649170)
        
        XCTAssertEqual(quake.code, "73649170")
        
        let expectedSeconds = TimeInterval(1636129710550) / 1000
        let decodedSeconds = quake.time.timeIntervalSince1970
        
        XCTAssertEqual(expectedSeconds, decodedSeconds)
    }
    
    func testGeoJSONDecoderDecodesGeoJSON() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        let decoded = try decoder.decode(GeoJSON.self, from: testQuakesData)
        
        XCTAssertEqual(decoded.quakes.count, 6)
        XCTAssertEqual(decoded.quakes[0].code, "73649170")
        
        let expectedSeconds = TimeInterval(1636129710550) / 1000
        let decodedSeconds = decoded.quakes[0].time.timeIntervalSince1970
        XCTAssertEqual(expectedSeconds, decodedSeconds)
    }
    
    func testQuakeDetailsDecoder() throws {
        let decoder = try JSONDecoder().decode(QuakeLocation.self, from: testDetail_hv72783692)
        XCTAssertEqual(decoder.latitude, 19.2189998626709)
    }
    
    func testClientDoesFetchEarthquakesData() async throws {
        let downloader = TestDownloader()
        let client = QuakeClient(downloader: downloader)
        let quakes = try await client.quakes
        
        XCTAssertEqual(quakes.count, 6)
    }
}
