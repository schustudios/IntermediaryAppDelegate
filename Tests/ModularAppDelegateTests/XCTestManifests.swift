import XCTest

#if !canImport(ObjectiveC)
#if canImport(UIKit)

public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AppInitTests.allTests),
    ]
}
#endif
#endif
