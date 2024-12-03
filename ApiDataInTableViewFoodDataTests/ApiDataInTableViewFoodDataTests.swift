//
//  ApiDataInTableViewFoodDataTests.swift
//  ApiDataInTableViewFoodDataTests
//
//  Created by Srikanth Kyatham on 12/2/24.
//

import XCTest
@testable import ApiDataInTableViewFoodData

final class ApiDataInTableViewFoodDataTests: XCTestCase {
    
    var objVC : ViewController?
    
    override func setUpWithError() throws {
        objVC = ViewController()
    }
    
    override func tearDownWithError() throws {
        objVC = nil
    }
    
    func testTotalFoodItems(){
        XCTAssertEqual(objVC?.totalFoodItems(), 0)
    }
    
    
}
