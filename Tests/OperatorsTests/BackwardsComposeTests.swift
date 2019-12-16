import XCTest
@testable import Operators
import SwiftCheck

final class BackwardComposeTests: XCTestCase {
    
    func testBackwardComposeOperator_GetTwoFunctions_ReturnNewFunction_IntToInt() {
        property("For every Function that return an Int we can pipe another function that get an int and return an int") <- forAll { (i : Int) in
            let sut = square <<< incr
            let expect = (i + 1) * (i + 1)
            return sut(i) == expect
        }
    }
    
    func testBackwardComposeOperator_GetTwoFunctions_ReturnNewFunction_IntToString() {
        property("For every Function that return an Int we can pipe another function that get an int and return a String") <- forAll { (i : Int) in
            let sut = toString <<< incr
            let expect = "\(i + 1)"
            return sut(i) == expect
        }
    }
    
    func testBackwardComposeOperator_GetTwoFunctions_ReturnNewFunction_ArrayIntToArrayString() {
        property("For every Function that return an Array<Int> we can pipe another function that get an Array<Int> and return an Array<String>") <- forAll { (i : [Int]) in
            let sut = toString <<< incr
            let expect = i.map { "\($0 + 1)" }
            return  i.map(sut) == expect
        }
    }
}
