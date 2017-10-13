//
//  main.swift
//  SimpleCalc
//
//  Created by Thipok Cholsaipant on 10/8/17.
//  Copyright © 2017 Thipok Cholsaipant. All rights reserved.
//

func add (a:Int, b:Int) -> (Int) {
    return a + b
}

func subtract (a:Int, b:Int) -> (Int) {
    return a - b
}

func multiply (a:Int, b:Int) -> (Int) {
    return a * b
}

func divaide (a:Int, b:Int) -> (Int) {
    return a / b
}


func add (a:[Int]) -> (Int) {
    var result = 0
    for num in a {
        result += num
    }
    return result
}

func mul (a:[Int]) -> (Int) {
    var result = 0
    for num in a {
        result *= num
    }
    return result

}


func avg (a:[Int]) -> (Int) {
    var sum = 0
    for num in a {
        sum += num
    }
    return sum / a.count
}

func count (a:[Int]) -> (Int) {
    return a.count
}

func calc(a:Int, b:Int, op: (Int, Int) -> (Int)) -> Int {
    return op(a,b)
}

func arrayCalc(a: [Int], op: ([Int]) -> (Int)) -> Int {
    return op(a)
}

var add = calc(a:0, b:0){$0 + $1}
var subtract = calc(a:0, b:0){$0 - $1}
var multiply = calc(a:0, b:0){$0 * $1}
var divide = calc(a:0, b:0){$0 / $1}

var mul = arrayCalc(a: [0]){
    var result = 0
    for num in $0 {
        result += num
    }
    return result}

var avg = arrayCalc(a: [0]){
    var sum = 0
    for num in $0 {
        sum += num
    }
    return sum / $0.count
}










//import Foundation
//
//// Enumeration of possible types of operation
//enum Operation {
//    // ----- Simple Calc -----
//    // User type one operand, operation, followed by operand. Operation is then performed
//    case binaryOperation((Int, Int) -> Int)
//    // User type one operand, followed by operation. Operation is then performed
//    case unaryOperation((Int) -> Int)
//    // User type the operands, then operation is then typed and performed
//    case aggregateOperation(([Int]) -> Int)
//    
//    // ----- Array Calc -----
//    // User can type an array of operands, then operation is then typed and performed
//    case arrayOperation(([Int]) -> Int)
//    case coordinateOperation((Dictionary<String, Int>, Dictionary<String, Int>) -> Dictionary<String, Int>)
//}
//
//// Enumeration of possible types of operands
//enum Operands {
//    case integerOperand([Int])
//    case arrayOperand([Int])
//    case coordinateOperand([Dictionary<String, Int>])
//}
//
//// ----- Simple Calc -----
//// Dictionary of possible operations and FUNCTIONS IN CLOSURE
//private var operations: Dictionary<String,Operation> = [
//    // .binaryOperation
//    "+" : Operation.binaryOperation({ $0 + $1 }),
//    "-" : Operation.binaryOperation({ $0 - $1 }),
//    "*" : Operation.binaryOperation({ $0 * $1 }),
//    "/" : Operation.binaryOperation({ $0 / $1 }),
//    "%" : Operation.binaryOperation({ ($0 * $1) * (1 - $1) }),
//    // .aggregateOperation
//    "count" : Operation.aggregateOperation({ $0.count }),
//    "avg" : Operation.aggregateOperation({
//        var sum = 0
//        for num in $0 {
//            sum += num
//        }
//        return sum / $0.count
//    }),
//    // .unaryOperation
//    "!" : Operation.unaryOperation({
//        var accumulator = 1
//        if $0 == 0 {
//            return 0
//        } else if $0 < 0 {
//            accumulator = -1
//        }
//        for i in 1...abs($0) {
//            accumulator *= i
//        }
//        return accumulator
//    }),
//]
//
//// ----- Array Calc -----
//// Dictionary of possible array operations and FUNCTIONS IN CLOSURE
//private var arrayOperations: Dictionary<String,Operation> = [
//    // .binaryOperation
//    "+" : Operation.arrayOperation({
//        var result = 0
//        for num in $0 {
//            result += num
//        }
//        return result }),
//    "*" : Operation.arrayOperation({
//        var result = 0
//        for num in $0 {
//            result *= num
//        }
//        return result }),
//    "count" : Operation.arrayOperation({ $0.count }),
//    "avg" : Operation.arrayOperation({
//        var sum = 0
//        for num in $0 {
//            sum += num
//        }
//        return sum / $0.count
//    }),
//]
//
//// ----- Points Calc -----
//// Dictionary of possible points operations and FUNCTIONS IN CLOSURE
//private var coordinateOperations: Dictionary<String,Operation> = [
//    // .binaryOperation
//    "+" : Operation.coordinateOperation({
//        var result = ["x": 0, "y": 0]
//        result["x"] = $0["x"]! + $1["x"]!
//        result["y"] = $0["y"]! + $1["y"]!
//        return result
//    }),
//    "*" : Operation.coordinateOperation({
//        var result = ["x": 0, "y": 0]
//        result["x"] = $0["x"]! - $1["x"]!
//        result["y"] = $0["y"]! - $1["y"]!
//        return result
//        
//    }),
//]
//
//// Dictionary of alternative string for operations
//private var alt: Dictionary<String, Set<String>> = [
//    "+" : ["add", "plus"],
//    "-" : ["sub", "subtract"],
//    "*" : ["x", "multiply", "mul"],
//    "/" : ["div", "divide"],
//    "%" : ["mod", "modulus"],
//    "!" : ["factorial", "fact"],
//    "avg" : ["average"],
//    "count" : ["sum"]
//]
//
//var inputEnded = false
//var oldOperands: [Int] = []
//var mathOperands: Operands?
//var mathOperator: Operation?
//var result: Int?
//var arrayCalc = false
//let arrayPattern = "^\\[(\\s?\\d+\\s?){1}(,(\\s?\\d+\\s?))*\\]$"
//let coordinatePattern = "^\\((\\s?\\d+\\s?),(\\s?\\d+\\s?)\\)$"
//
//// Reset the values in the calculator and raise the given error
//func resetAndRaiseError(error:String) {
//    print(error)
//    oldOperands = []
//    mathOperator = nil
//    arrayCalc = false
//}
//
//// Lookup keys for alternative string
//func lookUpAlt (lookup:String) -> String {
//    if operations[lookup] == nil {
//        for currentAlt in alt {
//            if currentAlt.value.contains(lookup) {
//                return currentAlt.key
//            }
//        }
//    }
//    return lookup
//}
//
//func lookUpOperation (lookup:String) -> (Operation?) {
//    if arrayCalc {
//        return arrayOperations[lookup]
//    } else {
//        return operations[lookup]
//    }
//}
//
//func identifyOperandsType (lookup:String) {
//    if mathOperands == nil {
//    if let operand = Int(lookup) {
//        
//        mathOperands = Operands.integerOperand([operand])
//    } else if lookup.range(of: arrayPattern, options: .regularExpression) != nil {
//        let trimmedString = lookup.trimmingCharacters(in: CharacterSet.init(charactersIn: "[]")).trimmingCharacters(in: .whitespaces)
//        let mappedStringArray = trimmedString.components(separatedBy: ",")
//        mathOperands = Operands.arrayOperand(mappedStringArray.map { Int($0.trimmingCharacters(in: .whitespaces))!})
//    } else if lookup.range(of: coordinatePattern, options: .regularExpression) != nil {
//        //
//    }
//}
//
//
//// Prints the introduction
//print("Enter an expression separated by returns:")
//
//// Run loop of reading and validate input
//while !inputEnded {
//    // Reads input from the console
//    let rawResponse = readLine(strippingNewline: true)!
//    
//    
//    // Check for integer operand. If matches, add it to operands array.
//    if  let value = Int(rawResponse){
//        oldOperands.append(value)
//        switch mathOperator {
//        case .binaryOperation?:
//            inputEnded = true
//        case .aggregateOperation?:
//            resetAndRaiseError(error: "Unexpected Operand. Please try again.")
//        default:
//            break
//        }
//        
//    // Check for arrays of operands. If matches, add it to operands array.
//    } else if rawResponse.range(of: arrayPattern, options: .regularExpression) != nil {
//        let trimmedString = rawResponse.trimmingCharacters(in: CharacterSet.init(charactersIn: "[]")).trimmingCharacters(in: .whitespaces)
//        let mappedStringArray = trimmedString.components(separatedBy: ",")
//        oldOperands = mappedStringArray.map { Int($0.trimmingCharacters(in: .whitespaces))!}
//        arrayCalc = true
//        
//    // Verify the given operator
//    } else if mathOperator == nil, let thisOperation = lookUpOperation(lookup: lookUpAlt(lookup: rawResponse)) {
//        switch thisOperation {
//        case .binaryOperation:
//            if oldOperands.count != 1{
//                resetAndRaiseError(error: "Unexpected Operation. Please try again.")
//            } else {
//                mathOperator = thisOperation
//            }
//        case .aggregateOperation:
//            if oldOperands.count < 1{
//                resetAndRaiseError(error: "Required at least one operand. please try again.")
//            } else {
//                inputEnded = true
//                mathOperator = thisOperation
//            }
//        case .unaryOperation:
//            if oldOperands.count != 1 {
//                resetAndRaiseError(error: "Expected one operand. Please try again.")
//            } else {
//                mathOperator = thisOperation
//                inputEnded = true
//            }
//        case .arrayOperation:
//            if oldOperands.count > 1 {
//                mathOperator = thisOperation
//                inputEnded = true
//            } else {
//                resetAndRaiseError(error: "Expected at least two operands. Please try again.")
//            }
//        case .coordinateOperation(_):
//            break
//        }
//    } else {
//        resetAndRaiseError(error: "Invalid Input. Please try again.")
//    }
//}
//
//// Performs the operation
//if let operation = mathOperator {
//    switch operation {
//    case .binaryOperation(let function):
//        result = function(oldOperands[0], oldOperands[1])
//    case .aggregateOperation(let function):
//        result = function(oldOperands)
//    case .unaryOperation(let function):
//        result = function(oldOperands[0])
//    case .arrayOperation(let function):
//        result = function(oldOperands)
//    case .coordinateOperation(_):
//        break
//    }
//}
//
//// Prints the result of the operand
//print("Result: \(result!)")

