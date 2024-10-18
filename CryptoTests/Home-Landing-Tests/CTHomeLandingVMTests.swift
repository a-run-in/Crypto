//
//  CTHomeLandingVMTests.swift
//  Crypto
//
//  Created by Arun on 18/10/24.
//

import XCTest
@testable import Crypto

class CTHomeLandingVMTests: XCTestCase {

    var viewModel: CTHomeLandingVM!
    var mockDelegate: MockDelegate!
    
    override func setUp() {
        super.setUp()
        viewModel = CTHomeLandingVM()
        mockDelegate = MockDelegate()
        viewModel.setDelegate(mockDelegate)
    }
    
    override func tearDown() {
        viewModel = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func testNumberOfRows_WhenListDataIsEmpty_ReturnsZero() {
        XCTAssertEqual(viewModel.numberOfRows(), 0)
    }
    
    func testNumberOfRows_WhenListDataIsNotEmpty_ReturnsCorrectCount() {
        viewModel.fetchHomeListingData {
            XCTAssertEqual(self.viewModel.numberOfRows(), 2)
        }
    }
    
    func testDataForCell_WhenIndexIsValid_ReturnsCorrectData() {
        let mockData = [
            CTHomeListingDataModel(name: "Bitcoin", symbol: "BTC", isNew: false, isActive: true, type: .coin),
            CTHomeListingDataModel(name: "Ethereum", symbol: "ETH", isNew: false, isActive: true, type: .coin)
        ]
        viewModel.listData = mockData
        let data = viewModel.dataForCell(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(data?.name, "Bitcoin")
        XCTAssertEqual(data?.symbol, "BTC")
    }
    
    func testDataForCell_WhenIndexIsOutOfBounds_ReturnsNil() {
        let data = viewModel.dataForCell(at: IndexPath(row: 10, section: 0))
        XCTAssertNil(data)
    }

    func testUpdateFilter_WithActiveFilter_FiltersCorrectly() {
        let mockData = [
            CTHomeListingDataModel(name: "Bitcoin", symbol: "BTC", isNew: false, isActive: true, type: .coin),
            CTHomeListingDataModel(name: "InactiveToken", symbol: "ITK", isNew: false, isActive: false, type: .token)
        ]
        viewModel.listData = mockData
        viewModel.sourceData = mockData
        viewModel.updateFilter(options: [.active])
        XCTAssertEqual(viewModel.numberOfRows(), 1)
        XCTAssertEqual(viewModel.dataForCell(at: IndexPath(row: 0, section: 0))?.name, "Bitcoin")
    }

    func testPerformSearch_FiltersByNameOrSymbol() {
        let mockData = [
            CTHomeListingDataModel(name: "Bitcoin", symbol: "BTC", isNew: false, isActive: true, type: .coin),
            CTHomeListingDataModel(name: "Ethereum", symbol: "ETH", isNew: false, isActive: true, type: .coin)
        ]
        viewModel.listData = mockData
        viewModel.sourceData = mockData
        viewModel.performSearch(for: "BTC")
        XCTAssertEqual(viewModel.numberOfRows(), 1)
        XCTAssertEqual(viewModel.dataForCell(at: IndexPath(row: 0, section: 0))?.symbol, "BTC")
    }
    
    func testResetDataSource_ResetsListData() {
        let mockData = [
            CTHomeListingDataModel(name: "Bitcoin", symbol: "BTC", isNew: false, isActive: true, type: .coin),
            CTHomeListingDataModel(name: "Ethereum", symbol: "ETH", isNew: false, isActive: true, type: .coin)
        ]
        viewModel.listData = mockData
        viewModel.sourceData = mockData
        viewModel.resetDataSource()
        XCTAssertEqual(viewModel.numberOfRows(), mockData.count)
    }
}

class MockDelegate: CTHomeLandingVMDelegate {
    var didCallRefreshTable = false

    func refreshTable() {
        didCallRefreshTable = true
    }
}
