//
//  CTFilterPopupVMTests.swift
//  Crypto
//
//  Created by Arun on 18/10/24.
//

import XCTest
@testable import Crypto

class CTFilterPopupVMTests: XCTestCase {

    var viewModel: CTFilterPopupVM!
    var mockDelegate: MockFilterViewModelDelegate!
    
    override func setUp() {
        super.setUp()
        let mockData = [
            CTFilterOptionDataModel(displayName: "Option 1", identifier: "option1", selected: false),
            CTFilterOptionDataModel(displayName: "Option 2", identifier: "option2", selected: true)
        ]
        viewModel = CTFilterPopupVM(input: mockData)
        mockDelegate = MockFilterViewModelDelegate()
        viewModel.setDelegate(mockDelegate)
    }
    
    override func tearDown() {
        viewModel = nil
        mockDelegate = nil
        super.tearDown()
    }

    func testNumberOfItems_ReturnsCorrectCount() {
        XCTAssertEqual(viewModel.numberOfItems(), 2)
    }

    func testDataForItem_ReturnsCorrectData() {
        let data = viewModel.dataForItem(at: IndexPath(item: 0, section: 0))
        XCTAssertEqual(data?.displayName, "Option 1")
        XCTAssertEqual(data?.identifier, "option1")
        XCTAssertEqual(data?.selected, false)
    }

    func testToggleSelection_UpdatesSelectedState() {
        viewModel.toggleSelection(at: IndexPath(item: 0, section: 0))
        let data = viewModel.dataForItem(at: IndexPath(item: 0, section: 0))
        XCTAssertTrue(data?.selected ?? false)
    }
    
    func testSelectedOptions_ReturnsOnlySelectedItems() {
        let selectedOptions = viewModel.selectedOptions
        XCTAssertEqual(selectedOptions.count, 1)
        XCTAssertEqual(selectedOptions.first?.identifier, "option2")
    }
    
    func testSetCancelButtonState_WhenNoOptionsSelected_ShouldShowCancelTrue() {
        viewModel.toggleSelection(at: IndexPath(item: 1, section: 0)) // deselecting the selected item
        viewModel.setCancelButtonState()
        XCTAssertTrue(viewModel.shouldShowCancel)
        XCTAssertEqual(viewModel.cencelButtonTitle, "Cancel")
    }

    func testSetCancelButtonState_WhenOptionsSelected_ShouldShowCancelFalse() {
        viewModel.toggleSelection(at: IndexPath(item: 0, section: 0)) // selecting an unselected item
        viewModel.setCancelButtonState()
        XCTAssertFalse(viewModel.shouldShowCancel)
        XCTAssertEqual(viewModel.cencelButtonTitle, "Clear")
    }
    
    func testSetCancelButtonState_CallsUpdateCancelButtonDisplayOnDelegate() {
        viewModel.setCancelButtonState()
        XCTAssertTrue(mockDelegate.didCallUpdateCancelButtonDisplay)
    }
}

class MockFilterViewModelDelegate: CTFilterViewModelDelegate {
    var didCallUpdateCancelButtonDisplay = false
    
    func updateCancelButtonDisplay() {
        didCallUpdateCancelButtonDisplay = true
    }
}
