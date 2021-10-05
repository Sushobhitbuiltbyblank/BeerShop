//
//  TestDetailViewModel.swift
//  BearShopTests
//
//  Created by Sushobhit.Jain on 05/10/21.
//

import XCTest
@testable import BearShop

class TestDetailViewModel: XCTestCase {

    var sut: BeerDetailViewModel!
    override func setUpWithError() throws {
        sut = BeerDetailViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDetailNotInitialize() throws {
        XCTAssertNil(sut.beer)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
