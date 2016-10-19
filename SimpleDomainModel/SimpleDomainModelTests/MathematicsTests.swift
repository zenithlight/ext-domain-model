//
//  MathematicsTests.swift
//  SimpleDomainModel
//
//  Created by Alexis Anand on 10/18/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

class MathematicsTests: XCTestCase {
    func testAdd() {
        let money1 = Money(amount: 500, currency: "USD")
        let money2 = Money(amount: 1000, currency: "GBP")
        
        let sum = money1.add(money2)
        
        XCTAssert(sum.amount == 1250 && sum.currency == "GBP")
    }
    
    func testSubtract() {
        let money1 = Money(amount: 9, currency: "USD")
        let money2 = Money(amount: 1, currency: "USD")
        
        let difference = money2.subtract(money1)
        
        XCTAssert(difference.amount == 8 && difference.currency == "USD")
    }
}
