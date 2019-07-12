import XCTest

#if canImport(UIKit)
import UIKit
@testable import IntermediaryAppDelegate

final class AppInitTests: XCTestCase {
    func testAppWillFinishLaunching() {
        let tmadEmpty = IntermediaryAppDelegate([])
        XCTAssert(tmadEmpty.application(UIApplication.shared, willFinishLaunchingWithOptions: nil))

        let tmad = IntermediaryAppDelegate([AppInitTestsAppDelegate()])
        XCTAssert(tmad.application(UIApplication.shared, willFinishLaunchingWithOptions: nil))
    }

    func testAppDidFinishLaunching() {
        // Test Default Value
        let tmadEmpty = IntermediaryAppDelegate([])
        XCTAssert(tmadEmpty.application(UIApplication.shared, didFinishLaunchingWithOptions: nil))

        let delegate = AppInitTestsAppDelegate()
        let tmad = IntermediaryAppDelegate([delegate])
        XCTAssert(tmad.application(UIApplication.shared, didFinishLaunchingWithOptions: nil) == false)

        tmad.applicationDidFinishLaunching(UIApplication.shared)
        XCTAssert(delegate.wasDidFinishLaunchingCalled)
    }

    static var allTests = [
        ("testAppWillFinishLaunching", testAppWillFinishLaunching),
    ]
}

class AppInitTestsAppDelegate: UIResponder, UIApplicationDelegate {
    var wasDidFinishLaunchingCalled = false
    open func application(_ application: UIApplication,
                          willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    open func application(_ application: UIApplication,
                          didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return false
    }

    func applicationDidFinishLaunching(_ application: UIApplication) {
        wasDidFinishLaunchingCalled = true
    }

}

#endif
