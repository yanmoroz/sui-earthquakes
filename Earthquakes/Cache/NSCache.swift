//
//  NSCache.swift
//  Earthquakes
//
//  Created by Yan Moroz on 15.02.2024.
//

import Foundation

extension NSCache<NSString, CacheEntryObject> {
    subscript(_ url: URL) -> CacheEntry? {
        get {
            let key = url.absoluteString as NSString
            let value = object(forKey: key)
            return value?.entry
        }
        set {
            let key = url.absoluteString as NSString
            if let entry = newValue {
                let value = CacheEntryObject(entry: entry)
                setObject(value, forKey: key)
            } else {
                removeObject(forKey: key)
            }
        }
    }
}
