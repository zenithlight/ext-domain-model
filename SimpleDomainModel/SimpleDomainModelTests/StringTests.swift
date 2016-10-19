//
//  StringTests.swift
//  SimpleDomainModel
//
//  Created by Alexis Anand on 10/18/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

class StringTests: XCTestCase {
    func testJobString() {
        let description = String(describing: Job(title: "Chocolate Eater", type: Job.JobType.Hourly(100)))
        XCTAssert(description == "[Job: title:Chocolate Eater type:Hourly wage:100.0]")
    }
    
    func testJobStringSalary() {
        let description = String(describing: Job(title: "Chocolate Maker", type: Job.JobType.Salary(10000)))
        XCTAssert(description == "[Job: title:Chocolate Maker type:Salary salary:10000]")
    }

    func testMoneyString() {
        var description = String(describing: Money(amount: 100, currency: "USD"))
        XCTAssert(description == "USD100")
        
        description = String(describing: Money(amount: 124, currency: "GBP"))
        XCTAssert(description == "GBP124")

        description = String(describing: Money(amount: 5160, currency: "EUR"))
        XCTAssert(description == "EUR5160")

        description = String(describing: Money(amount: -7, currency: "CAN"))
        XCTAssert(description == "CAN-7")
    }
    
    func testPersonString() {
        let description = String(describing: Person(firstName: "Larry", lastName: "Page", age: 43))
        XCTAssert(description == "[Person: firstName:Larry lastName:Page age:43 job:nil spouse:nil]")
    }
   
    func testFamilyString() {
        let spouse1 = Person(firstName: "William", lastName: "Gates", age: 60)
        let spouse2 = Person(firstName: "Melinda", lastName: "Gates", age: 52)
        
        let description = String(describing: Family(spouse1: spouse1, spouse2: spouse2))
        
        XCTAssert(description == "[Family: members:William Gates,Melinda Gates,]")
    }
}
