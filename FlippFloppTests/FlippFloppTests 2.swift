//
//  FlippFloppTests.swift
//  FlippFloppTests
//
//  Created by Balakumaran Srirangaswamy on 5/19/19.
//  Copyright © 2019 Bala. All rights reserved.
//

import XCTest
import ObjectMapper

@testable import FlippFlopp

class FlippFloppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBookResultsMapper() {
        let jsonDict: [String: Any] = ["list_name_encoded": "hardcover-fiction", "updated": "WEEKLY", "status": "OK", "numResults": 7]
        
        let testBookResults = Mapper<BookResults>().map(JSON: jsonDict)
        
        XCTAssertEqual(testBookResults?.listNameEncoded, "hardcover-fiction", "BookResults list_name_encoded mapped incorrectly")
        XCTAssertEqual(testBookResults?.status, "OK", "BookResults status mapped incorrectly")
        XCTAssertEqual(testBookResults?.numResults, 7, "BookResults num_results mapped incorrectly")
    }

}
