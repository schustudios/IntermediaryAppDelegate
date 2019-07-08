import XCTest

#if canImport(UIKit)
import UIKit
@testable import ModularAppDelegate

final class ModularAppDelegateTests: XCTestCase {
    func testDidFinishLaunching() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let tmad = TestModularAppDelegate()
        XCTAssert(tmad.application(UIApplication.shared, didFinishLaunchingWithOptions: nil))
        XCTAssert(false)
    }

    static var allTests = [
        ("testDidFinishLaunching", testDidFinishLaunching),
    ]
}


class TestModularAppDelegate: ModularAppDelegate {
    override var modules: [UIApplicationDelegate] = [TestAppDelegate()]

}
class TestAppDelegate: UIApplicationDelegate {
    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return false
    }

}
#else
final class ModularAppDelegateTests: XCTestCase {
    func testDidFinishLaunching() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssert(false)
    }

    static var allTests = [
        ("testDidFinishLaunching", testDidFinishLaunching),
    ]
}
#endif
