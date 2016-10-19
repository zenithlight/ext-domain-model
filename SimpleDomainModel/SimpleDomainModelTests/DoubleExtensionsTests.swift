//
//  DoubleExtensionsTests.swift
//  SimpleDomainModel
//
//  Created by Alexis Anand on 10/18/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

class DoubleExtensionsTests: XCTestCase {
    func testConversion() {
        XCTAssert(1.USD + (1 / 0.91).EUR == 2.0)
    }
    
    func testIdentity() {
        XCTAssert(0.14.GBP == 0.14.GBP)
    }
}
