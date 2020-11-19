//
//  Processor.swift
//  Calculator
//
//  Created by Viola on 9/17/20.
//  Copyright © 2020 Viola Stakhouskaya. All rights reserved.
//

import Foundation
import MathParser

struct Processor {
    
    var exitString = ""
    
    mutating func appendDigit (_ digit: String) {
        if !exitString.hasSuffix(")"), lastOperator?.hasPostfixOperand ?? true {
            exitString = exitString + digit
        }
    }
    
    mutating func appendOperator (_ processorOperator: ProcessorOperator){
        func add() {
            if processorOperator.requiresBracketsForPostfixOperand {
                exitString = exitString + processorOperator.rawValue + "("
            } else {
                exitString = exitString + processorOperator.rawValue
            }
        }
        if processorOperator.hasPrefixOperand {
            if lastNumber != nil || exitString.hasSuffix(")") || !(lastOperator?.hasPostfixOperand ?? true) {
                add()
            }
        } else {
            if !exitString.hasSuffix(")"), lastNumber == nil, lastOperator?.hasPostfixOperand ?? true {//
                add()
            }
        }
    }
    
    mutating func addLeftBracket() {
        if lastNumber == nil, exitString.hasSuffix(")") {
            exitString = exitString + "("
        }
    }

    mutating func addRightBracket() {
        if lastNumber != nil || exitString.hasSuffix(")") || !(lastOperator?.hasPostfixOperand ?? true), exitString.countAll("(") > exitString.countAll(")") {
            exitString = exitString + ")"
        }
    }
    
    mutating func appendPoint() {
        if let lastNumber = self.lastNumber, !lastNumber.contains(".") {
            exitString = exitString + "."
        }
    }
    
    
    mutating func backspace() {
        if let lastNumber = self.lastNumber {
            exitString.removeLast(lastNumber.count)
        }
        else if let lastOperator = self.lastOperator {
            while exitString.hasSuffix("(") {
                exitString.removeLast()
            }
            exitString.removeLast(lastOperator.rawValue.count)
        }
    }
    
    mutating func clearAll() {
        exitString = ""
    }
    
    mutating func calculateResult() {
        
        if let result = try? exitString.replacingOccurrences(of: "%", with: "*0.01").evaluate() { //если выражение верно, оно посчитает его
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 4
            exitString = formatter.string(from: NSNumber(value: result))!
        }
    }
    
    var lastOperator: ProcessorOperator? {
        var exitString = self.exitString
        while exitString.hasSuffix("(") {
            exitString.removeLast()
        }
        return ProcessorOperator.allCases.first { processorOperator in
            exitString.hasSuffix(processorOperator.rawValue)
        }
        
    }
    var lastNumber: String? { //может не быть числа на конце
        var exitString = self.exitString
        var lastNumber = ""
        while let last = exitString.last, last.isNumber || last == "." {
            lastNumber.insert(last, at: lastNumber.startIndex)
            exitString.removeLast()
        }
        if lastNumber.isEmpty {
            return nil
        } else {
            return lastNumber
        }
    }
}

extension Collection where Element: Equatable { //считает сколько элементов в массиве (символов в строке)
    
    func countAll(where check: (Element) -> Bool) -> Int {
        filter(check).count
    }
    
    func countAll(_ element: Element) -> Int {
        countAll(where: { $0 == element })
    }
}
