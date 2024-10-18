//
//  CacheManager.swift
//  Crypto
//
//  Created by Arun on 17/10/24.
//

import Foundation

class CacheManager<T: Codable> {
    
    private let cacheKey: String
    
    // Initializer to accept the cache key
    init(cacheKey: String) {
        self.cacheKey = cacheKey
    }
    
    // Method to store data in cache
    func storeData(_ model: T) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(model)
            UserDefaults.standard.set(data, forKey: cacheKey)
            print("Data successfully stored in cache.")
        } catch {
            print("Failed to encode and store data: \(error)")
        }
    }
    
    // Method to load data from cache
    func loadData() -> T? {
        if let cachedData = UserDefaults.standard.data(forKey: cacheKey) {
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(T.self, from: cachedData)
                print("Data successfully loaded from cache.")
                return model
            } catch {
                print("Failed to decode cached data: \(error)")
            }
        } else {
            print("No data found in cache.")
        }
        return nil
    }
    
    // Method to clear cache
    func clearCache() {
        UserDefaults.standard.removeObject(forKey: cacheKey)
        print("Cache cleared.")
    }
}
