import XCTest
@testable import Operators
import SwiftCheck

final class ForwardComposeTests: XCTestCase {
    
    func testForwardComposeOperator_GetTwoFunctions_ReturnNewFunction_IntToInt() {
        property("For every Function that return an Int we can pipe another function that get an int and return an int") <- forAll { (i : Int) in
            let sut = incr >>> square
            let expect = (i + 1) * (i + 1)
            return sut(i) == expect
        }
    }
    
    func testForwardComposeOperator_GetTwoFunctions_ReturnNewFunction_IntToString() {
        property("For every Function that return an Int we can pipe another function that get an int and return a String") <- forAll { (i : Int) in
            let sut = incr >>> toString
            let expect = "\(i + 1)"
            return sut(i) == expect
        }
    }
    
    func testForwardComposeOperator_GetTwoFunctions_ReturnNewFunction_ArrayIntToArrayString() {
        property("For every Function that return an Array<Int> we can pipe another function that get an Array<Int> and return an Array<String>") <- forAll { (i : [Int]) in
            let sut = incr >>> toString
            let expect = i.map { "\($0 + 1)" }
            return  i.map(sut) == expect
        }
    }
}
