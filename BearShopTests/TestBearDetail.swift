//
//  TestBearDetail.swift
//  BearShopTests
//
//  Created by Sushobhit.Jain on 05/10/21.
//

import XCTest
@testable import BearShop
class TestBearDetail: XCTestCase {
    var sut: BeerDetailsVC!
    var mockBeer : BeerElement!
    override func setUpWithError() throws {
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BeerDetailsVC") as? BeerDetailsVC
        if let path = Bundle.main.path(forResource: "FakeBeer", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSONDecoder().decode(BeerElement.self, from: data)
                mockBeer = json
                sut.viewModel.beer = mockBeer
                
            } catch {
                // handle error
            }
        }
        sut.loadView()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOutletConnected() throws {
        XCTAssertNotNil(sut.titleL)
        XCTAssertNotNil(sut.imageV)
        XCTAssertNotNil(sut.taglineL)
        XCTAssertNotNil(sut.descriptionL)
    }
    
    func testSetUpsetValue() {
        sut.setUpView()
        let expectedLabelText = "Pacific Hopped Amber Bitter."
        let actualLabelText = sut.taglineL.text
               
        XCTAssertEqual(expectedLabelText, actualLabelText, "Label text of: \(expectedLabelText) not equal to text: \(actualLabelText ?? "")")
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
