//
//  UnixDateConverterTests.swift
//  ProjektManhatannTests
//
//  Created by Grzegorz Gumieniak on 01/07/2021.
//

import XCTest
@testable import ProjektManhatann

class UnixDateConverterTests: XCTestCase {
    private var unixDateConverter: UnixDateConverter!
    override func setUp() {
        super.setUp()
        self.unixDateConverter = UnixDateConverter()
    }
    
    func testUnixDateTo01072021() {
        let expect = "01/07/2021"
        let result = unixDateConverter.convertUnixDateToStringDate(from: 1625090400)
        XCTAssertEqual(expect, result)
    }
    
    func testUnixDateInvalidDate() {
        let expect = "01/07/2021"
        let result = unixDateConverter.convertUnixDateToStringDate(from: 32)
        XCTAssertNotEqual(expect, result)
        
    }
    
    
}
