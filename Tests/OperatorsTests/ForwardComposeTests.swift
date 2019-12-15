import XCTest
@testable import Operators
import SwiftCheck

final class ForwardComposeTests: XCTestCase {
    
    func testForwardComposeOperator_GetTwoFunctions_ReturnNewFunction_IntToInt() {
        property("For every Function that return an Int we can pipe another function that get an int and return an int") <- forAll { (i : Int) in
            let sut = self.incr >>> self.square
            return sut(i) == (i + 1) * (i + 1)
        }
    }
    
    func testForwardComposeOperator_GetTwoFunctions_ReturnNewFunction_IntToString() {
        property("For every Function that return an Int we can pipe another function that get an int and return a String") <- forAll { (i : Int) in
            let sut = self.incr >>> self.toString
            return sut(i) == "\(i + 1)"
        }
    }
    
    func testForwardComposeOperator_GetTwoFunctions_ReturnNewFunction_ArrayIntToArrayString() {
        property("For every Function that return an Array<Int> we can pipe another function that get an Array<Int> and return an Array<String>") <- forAll { (i : [Int]) in
            let sut = self.incr >>> self.toString
            return  i.map(sut) == i.map { "\($0 + 1)" }
        }
    }
    
    private func incr(_ x: Int) -> Int {
        return x + 1
    }
    
    private func square(_ x: Int) -> Int {
        return x * x
    }
    
    private func toString(_ x: Int) -> String {
        return "\(x)"
    }
}
