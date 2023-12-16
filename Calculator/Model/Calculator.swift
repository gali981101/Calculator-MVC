//
//  Calculator.swift
//  Calculator
//
//  Created by Terry Jason on 2023/12/16.
//

import Foundation

struct Calculator {
    private var number: Double?
    private var intermediateCalculate: (n1: Double, calcMethod: String)?
}

struct Storage {
    fileprivate var total: Double = 0.0
}
// MARK: - Calculate

extension Calculator {
    
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    mutating func calculate(of sign: String) -> Double? {
        guard let number = number else { fatalError() }
        
        switch sign {
        case "C":
            return 0.0
        case "+/-":
            return number * -1
        case "%":
            return round((number * 0.01) * 100) / 100.0
        case "=":
            return finalCalculation(n2: number)
        default:
            intermediateCalculate = (number, sign)
        }
        
        return nil
    }
    
    private mutating func finalCalculation(n2: Double) -> Double {
        if let n1 = intermediateCalculate?.n1,
            let symbol = intermediateCalculate?.calcMethod {
            switch symbol {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "×":
                return n1 * n2
            default:
                return n1 / n2
            }
        }
        return n2
    }
    
}


