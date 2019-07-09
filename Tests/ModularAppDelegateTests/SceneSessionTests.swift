//
//  File.swift
//  
//
//  Created by Ryan Schumacher on 7/8/19.
//
import XCTest

#if canImport(UIKit)
import UIKit
@testable import ModularAppDelegate

final class SceneSessionTests: XCTestCase {

    @available(iOS 13.0, *)
    func testConfigureForConnection() {
        let delegate = SceneSessionAppDelegate()
        let tmad = SceneSessionModularAppDelegate([delegate])

        tmad.application(UIApplication.shared, didDiscardSceneSessions: [])
        XCTAssert(delegate.didCallDidDiscardSceneSessions)
    }
}

@available(iOS 13.0, *)
class SceneSessionModularAppDelegate: ModularAppDelegate, ConfigureSceneAppDelegate { }

@available(iOS 13.0, *)
class SceneSessionAppDelegate: UIResponder, UIApplicationDelegate {
    var didCallDidDiscardSceneSessions = false
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        didCallDidDiscardSceneSessions = true
    }


}
#endif
