import XCTest
@testable import Operators
import SwiftCheck

final class DiamondOperatorTests: XCTestCase {
    
    func testDiamondOperator_GetAFunction_ReturnNewInstanceAndSameType_Once() {
        property("For every int value the diamond return a new value of the same type") <- forAll { (i : Int) in
            let sut = incr <> incr
            let expected = i + 1 + 1
            return sut(i) == expected
        }
    }
    
    func testDiamondOperator_GetAFunction_ReturnNewInstanceAndSameType_Many() {
        property("For every int value more diamond operators chained togheter and return a new value of the same type") <- forAll { (i : Int) in
            let sut = incr <> incr <> square <> square
            let expected = ((i + 2) * (i + 2)) * ((i + 2) * (i + 2))
            print(sut(i))
            return sut(i) == expected
        }
    }
    
}

