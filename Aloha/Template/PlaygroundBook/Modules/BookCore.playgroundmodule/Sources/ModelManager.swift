//
//  ModelManager.swift
//  BookCore
//
//  Created by Anderson Alencar on 14/05/20.
//

import Foundation


public class ModelManager {
    
    public var number1 = 0
    public var number2 = 0
    public var operation = 0

    public func getBubble() -> Int {
        var number = 0
        if number1 == 0 {
            while number <= 1 {
                number = Int.random(in: 1...9)
            }
            return number
        } else if operation == 0 {
            number = Int.random(in: 1...2)
            return number
        } else {
            switch operation {
            case 1:
                number = Int.random(in: 1...9)
            default:
                while number >= number1 || number == 0 {
                    number = Int.random(in: 1...9)
            }
        }
            return number
        }
    }
    
    public func touchBubble(index: Int) {
        if number1 == 0 {
            number1 = index
        } else if operation  ==  0 {
            operation = index
        } else {
            number2 = index
        }
    }
    
    public init() {
        
    }
}
