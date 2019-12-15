import XCTest
@testable import Operators
import SwiftCheck

final class PipeForwardTests: XCTestCase {
    
    func testPipeForwardOperators_GetAValueAndAFunction_ReturnNewValueInstance_IntToInt() {
        property("For every int value the pipe forward return an incr of that value") <- forAll { (i : Int) in
            return (i |> self.incr) == (i + 1)
        }
    }
    
    func testPipeForwardOperators_GetAValueAndAFunction_ReturnNewValueInstance_IntToString() {
        property("For every int value we can get the matching string") <- forAll { (i : Int) in
            return (i |> self.toString) == "\(i)"
        }
    }
    
    func testPipeForwardOperators_GetAValueAndAFunction_ReturnNewValueInstance_ArrayIntToArrayString() {
           property("For every array of int value we can get the matching array of string") <- forAll { (i : [Int]) in
            return (i.map { $0 |> self.toString }) == i.map(self.toString)
           }
       }
    
    private func incr(_ x: Int) -> Int {
        return x + 1
    }
    
    private func toString(_ x: Int) -> String {
        return "\(x)"
    }
}
