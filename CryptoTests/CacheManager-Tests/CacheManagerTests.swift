//
//  CacheManagerTests.swift
//  Crypto
//
//  Created by Arun on 18/10/24.
//

import XCTest
@testable import Crypto

class CacheManagerTests: XCTestCase {
    
    var cacheManager: CacheManager<[String]>!
    let testCacheKey = "TestCacheKey"
    
    override func setUp() {
        super.setUp()
        cacheManager = CacheManager<[String]>(cacheKey: testCacheKey)
        UserDefaults.standard.removeObject(forKey: testCacheKey) // Clear any previous test data
    }
    
    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: testCacheKey) // Clean up after tests
        cacheManager = nil
        super.tearDown()
    }
    
    func testStoreData_SuccessfullyStoresDataInCache() {
        let testData = ["item1", "item2"]
        cacheManager.storeData(testData)
        
        if let cachedData = UserDefaults.standard.data(forKey: testCacheKey) {
            let decoder = JSONDecoder()
            let decodedData = try? decoder.decode([String].self, from: cachedData)
            XCTAssertEqual(decodedData, testData)
        } else {
            XCTFail("No data found in cache after storing.")
        }
    }
    
    func testLoadData_ReturnsCorrectDataFromCache() {
        let testData = ["item1", "item2"]
        cacheManager.storeData(testData)
        
        let loadedData = cacheManager.loadData()
        XCTAssertEqual(loadedData, testData)
    }
    
    func testLoadData_ReturnsNilWhenNoDataInCache() {
        let loadedData = cacheManager.loadData()
        XCTAssertNil(loadedData)
    }
    
    func testClearCache_RemovesDataFromCache() {
        let testData = ["item1", "item2"]
        cacheManager.storeData(testData)
        
        cacheManager.clearCache()
        let cachedData = UserDefaults.standard.data(forKey: testCacheKey)
        XCTAssertNil(cachedData, "Cache was not cleared properly.")
    }
}
