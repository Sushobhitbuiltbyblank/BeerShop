//
//  BeerShopTests.swift
//  BeerShopTests
//
//  Created by Sushobhit.Jain on 04/10/21.
//

import XCTest
@testable import BearShop

class BeerShopTests: XCTestCase {
    
    var sut : BeerListView!

    override func setUpWithError() throws {
        
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BeerListView") as? BeerListView
        sut.loadView()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testDefaultPageToOne() throws {
        XCTAssertEqual(sut.currentPage,1)
        
    }
    
    func testOutletConnected() throws {
        XCTAssertNotNil(sut.tableView)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//        }
//    }

}
