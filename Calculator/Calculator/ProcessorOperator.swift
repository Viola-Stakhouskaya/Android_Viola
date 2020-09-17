//
//  Operator.swift
//  Calculator
//
//  Created by Viola on 9/17/20.
//  Copyright © 2020 Viola Stakhouskaya. All rights reserved.
//

import Foundation

enum ProcessorOperator: String , CaseIterable {
    
    case plus = "+"
    case minus = "-"
    case divide = "÷"
    case multiply = "×"
    case percentage = "﹪"
    case root = " √"
    case sin = "sin"
    case cos = "cos"
    
    var hasPostfixOperand: Bool {
        switch self {
        case .percentage:
            return false
        default:
            return true
        }
    }
    
    var hasPrefixOperand: Bool {
        switch self {
        case .plus, .minus, .multiply, .divide, .percentage:
            return true
        case .root, .sin, .cos:
            return false
        }
    }
    
    var requiresBracketsForPostfixOperand: Bool {
        switch self {
        case .sin, .cos:
            return true
        default:
            return false
        }
    }
}
