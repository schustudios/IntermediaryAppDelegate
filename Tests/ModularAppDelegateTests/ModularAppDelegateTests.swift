import XCTest

#if canImport(UIKit)
import UIKit
@testable import ModularAppDelegate

final class ModularAppDelegateTests: XCTestCase {
    func testDidFinishLaunching() {
        let tmadEmpty = TestModularAppDelegate([])
        XCTAssert(tmadEmpty.application(UIApplication.shared, didFinishLaunchingWithOptions: nil))

        let tmad = TestModularAppDelegate([TestAppDelegate()])
        XCTAssert(tmad.application(UIApplication.shared, didFinishLaunchingWithOptions: nil))
    }

    static var allTests = [
        ("testDidFinishLaunching", testDidFinishLaunching),
    ]
}


class TestModularAppDelegate: ModularAppDelegate {

}

class TestAppDelegate: UIResponder, UIApplicationDelegate {
    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
}

#else
final class ModularAppDelegateTests: XCTestCase {
    func testDidFinishLaunching() {
        XCTAssert(false)
    }

    static var allTests = [
        ("testDidFinishLaunching", testDidFinishLaunching),
    ]
}
#endif
