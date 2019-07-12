//
//  AppLifecycleTests.swift
//  
//
//  Created by Ryan Schumacher on 7/8/19.
//

import XCTest

#if canImport(UIKit)
import UIKit
@testable import IntermediaryAppDelegate

final class AppLifecycleTests: XCTestCase {

    func testLifecycleEvents() {
        let delegate = AppLifecycleAppDelegate()
        let tmad = IntermediaryAppDelegate([delegate])

        tmad.applicationDidBecomeActive(UIApplication.shared)
        XCTAssert(delegate.didCallDidBecomeActive)

        tmad.applicationWillResignActive(UIApplication.shared)
        XCTAssert(delegate.didCallWillResignActive)

        tmad.applicationDidEnterBackground(UIApplication.shared)
        XCTAssert(delegate.didCallDidEnterBackground)

        tmad.applicationWillEnterForeground(UIApplication.shared)
        XCTAssert(delegate.didCallWillEnterForeground)

        tmad.applicationWillTerminate(UIApplication.shared)
        XCTAssert(delegate.didCallWillTerminate)

    }
}

class AppLifecycleAppDelegate: UIResponder, UIApplicationDelegate {
    var didCallDidBecomeActive = false
    open func applicationDidBecomeActive(_ application: UIApplication) {
        didCallDidBecomeActive = true
    }
    var didCallWillResignActive = false
    open func applicationWillResignActive(_ application: UIApplication) {
        didCallWillResignActive = true
    }
    var didCallDidEnterBackground = false
    open func applicationDidEnterBackground(_ application: UIApplication) {
        didCallDidEnterBackground = true
    }
    var didCallWillEnterForeground = false
    open func applicationWillEnterForeground(_ application: UIApplication) {
        didCallWillEnterForeground = true
    }

    var didCallWillTerminate = false
    open func applicationWillTerminate(_ application: UIApplication) {
        didCallWillTerminate = true
    }

}
#endif
