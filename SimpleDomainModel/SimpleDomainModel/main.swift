//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String
  
  public func convert(_ to: String) -> Money {
    switch (self.currency, to) {
    case (_, _) where self.currency == to:
      return Money(amount: self.amount, currency:self.currency)
    case ("USD", "GBP"):
      return Money(amount: self.amount / 2, currency: "GBP")
    case ("USD", "EUR"):
      return Money(amount: (self.amount / 2) * 3, currency: "EUR")
    case ("USD", "CAN"):
      return Money(amount: (self.amount / 4) * 5, currency: "CAN")
    case ("GBP", "USD"):
      return Money(amount: self.amount * 2, currency: "USD")
    case ("EUR", "USD"):
      return Money(amount: (self.amount / 3) * 2, currency: "USD")
    case ("CAN", "USD"):
      return Money(amount: (self.amount / 5) * 4, currency: "USD")
    default:
      fatalError("Unrecognized currency: \(to)")
    }
  }
  
  public func add(_ to: Money) -> Money {
    let lhs = self.convert(to.currency)
    let rhs = to
    
    return Money(amount: lhs.amount + rhs.amount, currency: to.currency)
  }
  public func subtract(_ from: Money) -> Money {
    let lhs = self.convert(from.currency)
    let rhs = from
    
    return Money(amount: lhs.amount - rhs.amount, currency: from.currency)
  }
}

////////////////////////////////////
// Job
//
open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
  
  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }
  
  open func calculateIncome(_ hours: Int) -> Int {
    switch type {
      case .Hourly(let rate): return Int(Double(hours) * rate)
      case .Salary(let yearly): return yearly
    }
  }
  
  open func raise(_ amt : Double) {
    switch type {
      case .Hourly(let rate): type = JobType.Hourly(rate + amt)
      case .Salary(let yearly): type = JobType.Salary(yearly + Int(amt))
    }
  }
}

////////////////////////////////////
// Person
//
open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0

  fileprivate var _job : Job? = nil
  open var job : Job? {
    get { return self._job }
    set(value) {
      if age > 16 {
        self._job = value
      }
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { return self._spouse }
    set(value) {
      if age > 18 {
        self._spouse = value
      }
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
    return "[Person: firstName:\(firstName) lastName:\(lastName) " +
      "age:\(age) job:\(job?.title) spouse:\(spouse?.firstName)]"
  }
}

////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
    members.append(spouse1)
    members.append(spouse2)
    
    spouse1.spouse = spouse2
    spouse2.spouse = spouse1
  }
  
  open func haveChild(_ child: Person) -> Bool {
    let legal = members.contains { (it) -> Bool in it.age > 21 }
    
    if legal {
      members.append(child)
    }
    
    return legal
  }
  
  open func householdIncome() -> Int {
    return members.reduce(0) { (accum, it) -> Int in
      if let salary = it.job?.calculateIncome(2000) {
        return accum + salary
      }
      else {
        return accum
      }
    }
  }
}





