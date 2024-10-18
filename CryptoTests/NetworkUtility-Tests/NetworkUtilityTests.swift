//
//  NetworkUtilityTests.swift
//  Crypto
//
//  Created by Arun on 18/10/24.
//

import XCTest
@testable import Crypto

class NetworkUtilityTests: XCTestCase {

    func testGetRequest_Success() {
        let expectation = self.expectation(description: "GET Request Success")
        let testURL = APIEndpoints.homeListing
        
        NetworkUtility.request(ofType: .get, url: testURL) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Expected non-nil data")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected success, but got error: \(error.localizedDescription)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetRequest_InvalidURL() {
        let expectation = self.expectation(description: "GET Request Invalid URL")
        let invalidURL = "InvalidURL"
        
        NetworkUtility.request(ofType: .get, url: invalidURL) { result in
            switch result {
            case .success(_):
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "unsupported URL")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

}
