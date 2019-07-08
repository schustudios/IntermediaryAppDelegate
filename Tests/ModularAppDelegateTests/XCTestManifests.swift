import XCTest

#if canImport(UIKit)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ModularAppDelegateTests.allTests),
    ]
}
#endif
