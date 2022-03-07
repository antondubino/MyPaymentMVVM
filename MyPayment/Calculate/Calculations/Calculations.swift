//
//  Calculations.swift
//  MyPayment
//
//  Created by Антон Дубино on 20.12.2021.
//

import Foundation

infix operator &/
 func &/(lhs: Double, rhs: Double) -> Double {
        if rhs == 0 { return 0 }
        return lhs/rhs
    }

infix operator ^^
func ^^(base: Double, comp: Double) -> Double{
    Array(repeating: base, count: Int(comp)).reduce(1, *)
}

class Calculations {
    
    static let shared = Calculations()
    
    func mortgageCalculateMonths(totalCost: Int, initial: Int, term: Int, bid: Double) -> Double {
        let bid100: Double = bid / 100 / 12
        let bid200 = (1 + bid100)^^Double(term)
        let result = (Double(totalCost) - Double(initial)) * (bid100 + (bid100 &/ (bid200 - 1)))
        return result
    }

    func mortgageCalculateMonthsInstallment(totalCost: Int, initial: Int, term: Int) -> Double {
        var result = (Double(totalCost) - Double(initial)) / Double(term)
        if term == 0 { result = 0 }
        return result
    }
    
    func mortgageCalculateYears(totalCost: Int, initial: Int, term: Int, bid: Double) -> Double {
        let months: Double = 12 * Double(term)
        let bid100: Double = bid / 100 / 12
        let bid200 = (1 + bid100)^^months
        let result = (Double(totalCost) - Double(initial)) * (bid100 + (bid100 &/ (bid200 - 1)))
        return result
    }
    
    func mortgageCalculateYearsInstallment(totalCost: Int, initial: Int, term: Int) -> Double {
        let months: Double = 12 * Double(term)
        var result = (Double(totalCost) - Double(initial)) / months
        if months == 0 { result = 0 }
        return result
    }
}
