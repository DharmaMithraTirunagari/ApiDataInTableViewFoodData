//
//  ApiDataInTableViewFoodDataTests.swift
//  ApiDataInTableViewFoodDataTests
//
//  Created by Srikanth Kyatham on 12/2/24.
//

import XCTest
@testable import ApiDataInTableViewFoodData

final class ApiDataInTableViewFoodDataTests: XCTestCase {
    
    var viewModel: FoodGroupViewModel!
    var mockNetworkManager: NetworkManagerDebug!
    
    override func setUpWithError() throws {
        super.setUp()
        mockNetworkManager = NetworkManagerDebug.shared
        viewModel = FoodGroupViewModel(networkManager: mockNetworkManager)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockNetworkManager = nil
    }
    
    func testGetDataFromServerSucess(){
        viewModel.getDataFromServer(urlString: " ") {
            XCTAssertFalse((self.viewModel?.arrFoodData.isEmpty) != nil)
            XCTAssertEqual(self.viewModel?.arrFoodData.count, 2)
            XCTAssertNotEqual(self.viewModel?.arrFoodData[0].name, "Breakfast")
            XCTAssertEqual(self.viewModel?.arrFoodData[1].name, "Indian food")
        }
    }
    
    func testTotalFoodItems() {
        viewModel.getDataFromServer(urlString: " ") {
            let totalFoodItems = self.viewModel?.totalFoodItems()
            XCTAssertEqual(totalFoodItems, 34)
        }
    }
    
    func testGetFoodItem() {
        viewModel.getDataFromServer(urlString: " ") {
            let foodItem = self.viewModel?.getFoodItem(at: 0)
            XCTAssertEqual(foodItem?.1?.name, "Margherita")
        }
    }
    
    func testGetFoodItemFromSecondGroup() {
        viewModel.getDataFromServer(urlString: " ") {
            let foodItem = self.viewModel?.getFoodItem(at: 18)
            XCTAssertEqual(foodItem?.1?.name, "Sunomono")
        }
    }
    
    func testFoodItemOutOfRange() {
        viewModel.getDataFromServer(urlString: " ") {
            let foodItem = self.viewModel?.getFoodItem(at: 100)
            XCTAssertNil(foodItem?.1?.name)
        }
    }
    

}
