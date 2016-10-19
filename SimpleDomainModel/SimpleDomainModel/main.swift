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
    public var amount: Int
    public var currency: String
 
    public func convert(_ to: String) -> Money {
        let newAmount: Int = fromUSD(toCurrency: to, amount: toUSD(fromCurrency: self.currency, amount: self.amount))
    
        return Money(amount: newAmount, currency: to)
    }
  
    public func add(_ to: Money) -> Money {
        let thisAmount: Int = toUSD(fromCurrency: self.currency, amount: self.amount)
        let thatAmount: Int = toUSD(fromCurrency: to.currency, amount: to.amount)
        
        let sum: Int = thatAmount + thisAmount
        
        return Money(amount: fromUSD(toCurrency: to.currency, amount: sum), currency: to.currency)
    }
  
    public func subtract(_ from: Money) -> Money {
        let thisAmount: Int = toUSD(fromCurrency: self.currency, amount: self.amount)
        let thatAmount: Int = toUSD(fromCurrency: from.currency, amount: from.amount)
        
        let difference: Int = thatAmount - thisAmount
        
        return Money(amount: fromUSD(toCurrency: self.currency, amount: difference), currency: from.currency)
    }
    
    private func toUSD(fromCurrency: String, amount: Int) -> Int {
        if fromCurrency == "USD" {
            return amount
        }
        
        if fromCurrency == "GBP" {
            return Int(Double(amount) * (1 / 0.5))
        }
        
        if fromCurrency == "EUR" {
            return Int(Double(amount) * (1 / 1.5))
        }
        
        if fromCurrency == "CAN" {
            return Int(Double(amount) * (1 / 1.25))
        }
        
        else {
            return 0
        }
    }
    
    private func fromUSD(toCurrency: String, amount: Int) -> Int {
        if toCurrency == "USD" {
            return amount
        }
        
        if toCurrency == "GBP" {
            return Int(Double(amount) * 0.5)
        }
        
        if toCurrency == "EUR" {
            return Int(Double(amount) * 1.5)
        }
        
        if toCurrency == "CAN" {
            return Int(Double(amount) * 1.25)
        }
        
        else {
            return 0
        }
    }
}

////////////////////////////////////
// Job
//
open class Job {
  fileprivate var title: String
  fileprivate var type: JobType

    public enum JobType {
      case Hourly(Double)
      case Salary(Int)
    }
  
    public init(title: String, type: JobType) {
        self.title = title
        self.type = type
    }
  
    open func calculateIncome(_ hours: Int) -> Int {
        switch self.type {
            case .Hourly(let wage):
                return Int(wage * Double(hours))
            case .Salary(let salary):
                return salary
        }
    }
  
    open func raise(_ amt : Double) {
        switch self.type {
            case .Hourly(let wage):
                self.type = JobType.Hourly(wage + amt)
            case .Salary(let salary):
                self.type = JobType.Salary(salary + Int(amt))
        }
    }
}

////////////////////////////////////
// Person
//
open class Person {
    open var firstName: String = ""
    open var lastName: String = ""
    open var age: Int = 0
    
    fileprivate var _job: Job? = nil
        open var job: Job? {
        get { return self._job }
        set(value) {
            if self.age >= 16 {
                self._job = value
            }
        }
    }
  
    fileprivate var _spouse: Person? = nil
        open var spouse: Person? {
        get { return self._spouse }
        set(value) {
            if self.age >= 18 {
                self._spouse = value;
            }
        }
    }
  
    public init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
  
    open func toString() -> String {
        //return String(describing: self)
        return "[Person: firstName:" + self.firstName + " lastName:" + self.lastName + " age:" + String(self.age) + " job:" + String(describing: self.job) + " spouse:" + String(describing: self.spouse) + "]";
    }
}

////////////////////////////////////
// Family
//
open class Family {
    fileprivate var members: [Person] = []
  
    public init(spouse1: Person, spouse2: Person) {
        if spouse1.spouse == nil && spouse2.spouse == nil && (spouse1.age >= 21 || spouse2.age >= 21) {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            
            self.members.append(spouse1);
            self.members.append(spouse2);
        }
    }
  
    open func haveChild(_ child: Person) -> Bool {
        child.age = 0;
        self.members.append(child)
        return true
    }
  
    open func householdIncome() -> Int {
        var total: Int = 0
     
        for member in self.members {
            if member.job != nil {
                total += member.job!.calculateIncome(2000)
            }
        }
        
        return total
    }
}





