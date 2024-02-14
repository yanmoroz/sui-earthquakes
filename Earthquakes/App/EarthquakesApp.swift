//
//  EarthquakesApp.swift
//  Earthquakes
//
//  Created by Yan Moroz on 14.02.2024.
//

import SwiftUI

@main
struct EarthquakesApp: App {
    
    @StateObject var quakesProvider = QuakesProvider()
    
    var body: some Scene {
        WindowGroup {
            QuakesView()
                .environmentObject(quakesProvider)
        }
    }
}
