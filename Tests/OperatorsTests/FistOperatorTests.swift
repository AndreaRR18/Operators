import XCTest
@testable import Operators
import SwiftCheck

final class FishOperatorTests: XCTestCase {
    
    //MARK: - Log
    func testFishOperatorOperator_GetTwoFunctionsWithDifferentInputOutput_ReturnNewFunction_IntToIntAndLog() {
        property("For every Function that return an Optional<Int> we can pipe another function that get an Int and return an Optional<Int>") <- forAll { (i : Int) in
            let sut = incr >>> addGenericLog >=> square >>> addGenericLog
            let expected = ((i + 1) * (i + 1), ["TEST", "TEST"])
            return sut(i) == expected
        }
    }
    
    func testFishOperatorOperator_GetTwoFunctionsWithDifferentInputOutput_ReturnNewFunction_IntToOptionalStringAndLog() {
        property("For every Function that return an Optional<Int> we can pipe another function that get an Int and return an Optional<String>") <- forAll { (i : Int) in
            let sut = incr >>> addGenericLog >=> toString >>> addGenericLog
            let expected = ("\(i + 1)", ["TEST","TEST"])
            return sut(i) == expected
        }
    }
    
    //MARK: - Optional
    func testFishOperatorOperator_GetTwoFunctionsWithDifferentInputOutput_ReturnNewFunction_IntToOptionalInt() {
        property("For every Function that return an Optional<Int> we can pipe another function that get an Int and return an Optional<Int>") <- forAll { (i : Int) in
            let sut = incr >=> toOptional >=> square
            let expected = Optional.some((i + 1) * (i + 1))
            
            switch sut(i) {
            case .some(let value):
                return value == expected
            case .none:
                return false
            }
        }
    }
    
    func testFishOperatorOperator_GetTwoFunctionsWithDifferentInputOutput_ReturnNewFunction_IntToNil() {
        property("For every Function that return an Optional<Int> we can pipe another function that get an Int and return nil") <- forAll { (i : Int) in
            let sut = incr >=> toNil >=> square
            
            switch sut(i) {
            case .some(_):
                return false
            case .none:
                return true
            }
        }
    }
    
    func testFishOperatorOperator_GetTwoFunctionsWithDifferentInputOutput_ReturnNewFunction_IntToOptionalString() {
        property("For every Function that return an Optional<Int> we can pipe another function that get an Int and return an Optional<String>") <- forAll { (i : Int) in
            let sut = incr >=> toOptional >=> toString
            let expected = "\(i + 1)"
            
            switch sut(i) {
            case .some(let value):
                return value == expected
            case .none:
                return false
            }
        }
    }
    
    //MARK: Array
    func testFishOperatorOperator_GetTwoFunctionsWithDifferentInputOutput_ReturnNewFunction_ArrayIntToArrayOptionalInt() {
        property("For every Function that return an Array<Optional<Int>> we can pipe another function that get an Array<Int> and return an Array<Optional<Int>>") <- forAll { (i : [Int]) in
            let sut = incr >=> toOptional >=> square
            
            return i.map(sut).filter { $0 == nil }.isEmpty && i.map(sut) == i.map { ($0 + 1) * ($0 + 1) }
        }
    }
    
    func testFishOperatorOperator_GetTwoFunctionsWithDifferentInputOutput_ReturnNewFunction_ArrayIntToArrayOptionalString() {
        property("For every Function that return an Array<Optional<Int>> we can pipe another function that get an Array<Optinal<Int>> and return an Array<Optional<String>>") <- forAll { (i : [Int]) in
            let sut = incr >=> toOptional >=> toString
            
            return i.map(sut).filter { $0 == nil }.isEmpty && i.map(sut) == i.map { "\($0 + 1)" }
        }
    }
    
    func testFishOperatorOperator_GetTwoFunctionsWithDifferentInputOutput_ReturnNewFunction_ArrayIntToArrayNil() {
        property("For every Function that return an Array<Optional<Int>> we can pipe another function that get an Array<Optinal<Int>> and return an Array of nil") <- forAll { (i : [Int]) in
            let sut = incr >=> toNil >=> toString
            return i.map(sut).filter { $0 != nil }.isEmpty
        }
    }
}
