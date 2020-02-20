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

// How we can evaluate from single input multiple expressions? 🤔
// One way would be if we could have a binary tree with operation as parent and left&right expressions as children.
struct BinaryTree<T: BinaryFloatingPoint> {
    var root: Operation
    var left: T
    var right: T
    
    lazy var evaluation: T = {
        try! calc(self.left, self.right, self.root)
    }()
}

// Similar to line 33 with multiple calls of same function,
// but more readable and with addition of lazy var from BinaryTree even better 🥳
var aTree = BinaryTree(root: .mul,
                       left: try calc(9.0, 2.0, .add),
                       right: try calc(2.2, 3.1, .sub))
print("this tree evaluates to: \(aTree.evaluation)")

var anotherTree = BinaryTree(root: .div,
                             left: aTree.evaluation,
                             right: (aTree.evaluation - 3) * 2)
print(anotherTree.evaluation)
