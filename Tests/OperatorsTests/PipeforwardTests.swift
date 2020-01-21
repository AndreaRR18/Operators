import XCTest
@testable import Operators
import SwiftCheck

final class PipeForwardTests: XCTestCase {
    
    //MARK - Pipeforward
    func testPipeForwardOperators_GetAValueAndAFunction_ReturnNewValueInstance_IntToInt() {
        property("For every int value the pipe forward return an incr of that value") <- forAll { (i : Int) in
            let sut = (i |> incr)
            let expect = (i + 1)
            return sut == expect
        }
    }
    
    func testPipeForwardOperators_GetAValueAndAFunction_ReturnNewValueInstance_IntToString() {
        property("For every int value we can get the matching string") <- forAll { (i : Int) in
            let sut = (i |> toString)
            let expect = "\(i)"
            return sut == expect
        }
    }
    
    func testPipeForwardOperators_GetAValueAndAFunction_ReturnNewValueInstance_ArrayIntToArrayString() {
        property("For every array of int value we can get the matching array of string") <- forAll { (i : [Int]) in
            let sut = (i.map { $0 |> toString })
            let expect = i.map(toString)
            return sut == expect
        }
    }
    
    //MARK - Pipeforward inout
    func testInoutForwardOperator_GetAValueAndInoutFunction_ReturnMutatedValueInstance_IntToInt() {
        property("For every int value the pipe function return an incr of that value") <- forAll { (i : Int) in
            let inoutFunction = toInout(incr)
            var sut = i
            sut |> inoutFunction
            let expect = (i + 1)
            return sut == expect
        }
    }
    
    //MARK - Pipe function
    func testPipeFunction_GetAValueAndAFunction_ReturnNewValueInstance_IntToInt() {
        property("For every int value the pipe function return an incr of that value") <- forAll { (i : Int) in
            let sut = with(i, incr)
            let expect = (i + 1)
            return sut == expect
        }
    }
    
    func testPipeFunction_GetAValueAndAFunction_ReturnNewValueInstance_IntToString() {
        property("For every int value we can get the matching string") <- forAll { (i : Int) in
            let sut = with(i, toString)
            let expect = "\(i)"
            return sut == expect
        }
    }
    
    func testPipeFunction_GetAValueAndAFunction_ReturnNewValueInstance_ArrayIntToArrayString() {
        property("For every array of int value we can get the matching array of string") <- forAll { (i : [Int]) in
            let sut = (i.map { with($0, toString) })
            let expect = i.map(toString)
            return sut == expect
        }
    }
    
    //MARK - Pipe function inout
    func testInoutPipeInoutFunction_GetAValueAndInoutFunction_ReturnMutatedValueInstance_IntToInt() {
        property("For every int value the pipe function return an incr of that value") <- forAll { (i : Int) in
            let inoutFunction = toInout(incr)
            var sut = i
            withInout(&sut,  inoutFunction)
            let expect = (i + 1)
            return sut == expect
        }
    }
    
}
