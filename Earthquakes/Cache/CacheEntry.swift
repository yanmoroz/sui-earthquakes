//
//  CacheEntry.swift
//  Earthquakes
//
//  Created by Yan Moroz on 15.02.2024.
//

import Foundation

final class CacheEntryObject {
    let entry: CacheEntry
    
    init(entry: CacheEntry) {
        self.entry = entry
    }
}

enum CacheEntry {
    case inProgress(Task<QuakeLocation, Error>)
    case ready(QuakeLocation)
}
