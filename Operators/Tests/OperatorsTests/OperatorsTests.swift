import XCTest
@testable import Operators

final class OperatorsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Operators().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
