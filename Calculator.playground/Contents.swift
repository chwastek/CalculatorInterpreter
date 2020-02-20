import PlaygroundSupport
import Foundation

// Basic approach with a simple function evaluating a single expression, with option to input another expressions.
enum Operation {
    case add
    case sub
    case mul
    case div
}

enum CalculationError: Swift.Error {
    case forbidden
    case notImplemented
}

typealias MathExpression<T:Numeric & BinaryFloatingPoint> = (T, T, Operation) -> T
func calc<T:Numeric & BinaryFloatingPoint> (_ left: T,_ right: T,_ operation: Operation) throws -> T {
    switch operation {
    case .add:
        return left + right
    case .sub:
        return left - right
    case .mul:
        return left * right
    case .div:
        return left / right
    }
}

try calc(2, 3, .add)
try calc(try calc(2, 3, .add), try calc(2, 3, .add), .mul) // (2+3) * (2+3)
try calc(try calc(try calc(2, 3, .add), try calc(2, 3, .add), .mul), 3, .div) // (2+3) * (2+3) / 3
