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
    
    var vcTest: ViewController!

    override func setUp() {
        super.setUp()
        vcTest = ViewController()
    }

    override func tearDown() {
        vcTest = nil
        super.tearDown()
    }
    
    func testBookMapper() {
        let jsonDict: [String: Any] = ["title": "FIRE AND BLOOD", "primary_isbn10": "152479628X", "book_image_width": 326, "publisher": "Bantam"]
        
        let testBook = Mapper<Book>().map(JSON: jsonDict)
        
        XCTAssertEqual(testBook?.title, "FIRE AND BLOOD", "Book primary_isbn10 mapped incorrectly")
        XCTAssertEqual(testBook?.bookImageWidth, 326, "Book book_image_width mapped incorrectly")
    }

    func testBookResultsMapper() {
        let jsonDict: [String: Any] = ["list_name_encoded": "hardcover-fiction", "updated": "WEEKLY", "status": "OK", "num_results": 7]
        
        let testBookResults = Mapper<BookResults>().map(JSON: jsonDict)
        
        XCTAssertEqual(testBookResults?.listNameEncoded, "hardcover-fiction", "BookResults list_name_encoded mapped incorrectly")
        XCTAssertEqual(testBookResults?.status, "OK", "BookResults status mapped incorrectly")
        XCTAssertEqual(testBookResults?.numResults, 7, "BookResults num_results mapped incorrectly")
    }
    
    func testGetDataFromImageURLL() {
        let imageUrlString = "https://s1.nyt.com/du/books/images/9781524796280.jpg"
        
        let imageData = vcTest.getDataFromImageURL(urlString: imageUrlString)
        
        guard imageData != nil else {
            XCTFail("Image data not retrieved from URL")
            return
        }
    }

}
